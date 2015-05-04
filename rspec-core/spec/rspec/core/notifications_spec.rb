require 'rspec/core/notifications'

RSpec.describe "FailedExampleNotification" do
  include FormatterSupport

  let(:example) { new_example(:status => :failed) }
  exception_line = __LINE__ + 1
  let(:exception) { instance_double(Exception, :backtrace => [ "#{__FILE__}:#{exception_line}"], :message => 'Test exception') }
  let(:notification) { ::RSpec::Core::Notifications::ExampleNotification.for(example) }

  before do
    example.execution_result.exception = exception
    example.metadata[:absolute_file_path] = __FILE__
  end

  it 'provides a description' do
    expect(notification.description).to eq(example.full_description)
  end

  it 'provides `colorized_formatted_backtrace`, which formats the backtrace and colorizes it' do
    allow(RSpec.configuration).to receive(:color_enabled?).and_return(true)
    expect(notification.colorized_formatted_backtrace).to eq(["\e[36m# #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{exception_line}\e[0m"])
  end

  describe "fully formatted failure output" do
    def fully_formatted(*args)
      notification.fully_formatted(1, *args)
    end

    def dedent(string)
      string.gsub(/^ +\|/, '')
    end

    # ANSI codes aren't easy to read in failure output, so use tags instead
    class TagColorizer
      def self.wrap(text, code_or_symbol)
        "<#{code_or_symbol}>#{text}</#{code_or_symbol}>"
      end
    end

    context "when the exception is a MultipleExpectationsNotMetError" do
      RSpec::Matchers.define :fail_with_description do |desc|
        match { false }
        description { desc }
        failure_message { "expected pass, but #{desc}" }
      end

      def capture_and_normalize_aggregation_error
        backtrace_truncation_frames = caller.length + 2

        begin
          yield
        rescue RSpec::Expectations::MultipleExpectationsNotMetError => failure
          # To keep the output manageable, truncate the backtraces...
          ([failure] + failure.all_exceptions).each do |exception|
            exception.set_backtrace(exception.backtrace[0..-backtrace_truncation_frames])
            exception.backtrace.map! { |line| line.sub(/:in .*$/, '') }
          end

          failure
        end
      end

      let(:aggregate_line) { __LINE__ + 3 }
      let(:exception) do
        capture_and_normalize_aggregation_error do
          aggregate_failures("multiple expectations") do
            expect(1).to fail_with_description("foo")
            expect(1).to fail_with_description("bar")
          end
        end
      end

      it 'provides a summary composed of example description, failure count and aggregate backtrace' do
        expect(fully_formatted.lines.first(5)).to eq(dedent(<<-EOS).lines.to_a)
          |
          |  1) Example
          |     Got 2 failures from failure aggregation block "multiple expectations".
          |     # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line}
          |
        EOS
      end

      it 'lists each individual expectation failure, with a backtrace relative to the aggregation block' do
        expect(fully_formatted.lines.to_a.last(8)).to eq(dedent(<<-EOS).lines.to_a)
          |
          |     1.1) Failure/Error: expect(1).to fail_with_description("foo")
          |            expected pass, but foo
          |          # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line + 1}
          |
          |     1.2) Failure/Error: expect(1).to fail_with_description("bar")
          |            expected pass, but bar
          |          # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line + 2}
        EOS
      end

      it 'uses the `failure` color in the summary output' do
        expect(fully_formatted(TagColorizer)).to include(
          '<red>Got 2 failures from failure aggregation block "multiple expectations"</red>.'
        )
      end

      it 'uses the `failure` color for the sub-failure messages' do
        expect(fully_formatted(TagColorizer)).to include(
         '<red>  expected pass, but foo</red>',
         '<red>  expected pass, but bar</red>'
        )
      end

      context "when the failure happened in a shared example group" do
        before do |ex|
          example.metadata[:shared_group_inclusion_backtrace] << RSpec::Core::SharedExampleGroupInclusionStackFrame.new(
            "Stuff", "./some_shared_group_file.rb:13"
          )
        end

        it "includes the shared group backtrace as part of the aggregate failure backtrace" do
          expect(fully_formatted.lines.first(6)).to eq(dedent(<<-EOS).lines.to_a)
            |
            |  1) Example
            |     Got 2 failures from failure aggregation block "multiple expectations".
            |     Shared Example Group: "Stuff" called from ./some_shared_group_file.rb:13
            |     # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line}
            |
          EOS
        end

        it "does not include the shared group backtrace in the sub-failure backtraces" do
          expect(fully_formatted.lines.to_a.last(8)).to eq(dedent(<<-EOS).lines.to_a)
            |
            |     1.1) Failure/Error: expect(1).to fail_with_description("foo")
            |            expected pass, but foo
            |          # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line + 1}
            |
            |     1.2) Failure/Error: expect(1).to fail_with_description("bar")
            |            expected pass, but bar
            |          # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line + 2}
          EOS
        end
      end

      context "when there are failures and other errors" do
        let(:aggregate_line) { __LINE__ + 3 }
        let(:exception) do
          capture_and_normalize_aggregation_error do
            aggregate_failures("multiple expectations") do
              expect(1).to fail_with_description("foo")
              raise "boom"
            end
          end
        end

        it 'lists both types in the exception listing' do
          expect(fully_formatted.lines.to_a.last(9)).to eq(dedent(<<-EOS).lines.to_a)
            |
            |     1.1) Failure/Error: expect(1).to fail_with_description("foo")
            |            expected pass, but foo
            |          # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line + 1}
            |
            |     1.2) Failure/Error: raise "boom"
            |          RuntimeError:
            |            boom
            |          # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line + 2}
           EOS
        end
      end

      context "in a pending spec" do
        before do
          example.execution_result.status = :pending
          example.execution_result.pending_message = 'Some pending reason'
          example.execution_result.pending_exception = exception
          example.execution_result.exception = nil
        end

        it 'includes both the pending message and aggregate summary' do
          expect(fully_formatted.lines.first(6)).to eq(dedent(<<-EOS).lines.to_a)
            |
            |  1) Example
            |     # Some pending reason
            |     Got 2 failures from failure aggregation block "multiple expectations".
            |     # #{RSpec::Core::Metadata.relative_path(__FILE__)}:#{aggregate_line}
            |
          EOS
        end

        it 'uses the `pending` color in the summary output' do
          expect(fully_formatted(TagColorizer)).to include(
            '<yellow>Got 2 failures from failure aggregation block "multiple expectations"</yellow>.'
          )
        end

        it 'uses the `pending` color for the sub-failure messages' do
          expect(fully_formatted(TagColorizer)).to include(
           '<yellow>  expected pass, but foo</yellow>',
           '<yellow>  expected pass, but bar</yellow>'
          )
        end
      end
    end
  end

  describe '#message_lines' do
    let(:example_group) { class_double(RSpec::Core::ExampleGroup, :metadata => {}, :parent_groups => [], :location => "#{__FILE__}:#{__LINE__}") }

    before do
      allow(example).to receive(:example_group) { example_group }
    end

    it 'should return failure_lines without color' do
      lines = notification.message_lines
      expect(lines[0]).to match %r{\AFailure\/Error}
      expect(lines[1]).to match %r{\A\s*Test exception\z}
    end

    it 'returns failures_lines without color when they are part of a shared example group' do
      example.metadata[:shared_group_inclusion_backtrace] <<
        RSpec::Core::SharedExampleGroupInclusionStackFrame.new("foo", "bar")

      lines = notification.message_lines
      expect(lines[0]).to match %r{\AFailure\/Error}
      expect(lines[1]).to match %r{\A\s*Test exception\z}
    end

    if String.method_defined?(:encoding)
      it "returns failures_lines with invalid bytes replace by '?'" do
        message_with_invalid_byte_sequence =
          "\xEF \255 \xAD I have bad bytes".force_encoding(Encoding::UTF_8)
        allow(exception).to receive(:message).
          and_return(message_with_invalid_byte_sequence)

        lines = notification.message_lines
        expect(lines[0]).to match %r{\AFailure\/Error}
        expect(lines[1].strip).to eq("? ? ? I have bad bytes")
      end
    end
  end
end

module RSpec::Core::Notifications
  RSpec.describe ExamplesNotification do
    include FormatterSupport

    describe "#notifications" do
      it 'returns an array of notification objects for all the examples' do
        reporter = RSpec::Core::Reporter.new(RSpec.configuration)
        example = new_example

        reporter.example_started(example)
        reporter.example_passed(example)

        notification = ExamplesNotification.new(reporter)
        expect(notification.notifications).to match [
          an_instance_of(ExampleNotification) & an_object_having_attributes(:example => example)
        ]
      end
    end
  end
end
