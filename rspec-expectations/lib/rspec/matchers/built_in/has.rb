module RSpec
  module Matchers
    module BuiltIn
      # @api private
      # Provides the implementation for dynamic predicate matchers.
      # Not intended to be inherited directly.
      class DynamicPredicate < BaseMatcher
        include BeHelpers

        def initialize(method_name, *args, &block)
          @method_name, @args, @block = method_name, args, block
        end
        ruby2_keywords :initialize if respond_to?(:ruby2_keywords, true)

        # @private
        def matches?(actual, &block)
          @actual = actual
          @block ||= block
          predicate_accessible? && predicate_matches?
        end

        # @private
        def does_not_match?(actual, &block)
          @actual = actual
          @block ||= block
          predicate_accessible? && predicate_matches?(false)
        end

        # @api private
        # @return [String]
        def failure_message
          failure_message_expecting(true)
        end

        # @api private
        # @return [String]
        def failure_message_when_negated
          failure_message_expecting(false)
        end

        # @api private
        # @return [String]
        def description
          "#{method_description}#{args_to_sentence}"
        end

      private

        def predicate_accessible?
          @actual.respond_to? predicate
        end

        def private_predicate?
          @actual.private_methods.include? predicate
        end

        def predicate_result
          @predicate_result = actual.__send__(predicate_method_name, *@args, &@block)
        end

        def predicate_method_name
          predicate
        end

        def predicate_matches?(value=true)
          if RSpec::Expectations.configuration.strict_predicate_matchers?
            value == predicate_result
          else
            value == !!predicate_result
          end
        end

        def root
          self.class::REGEX.match(@method_name).captures.first
        end

        def method_description
          EnglishPhrasing.split_words(@method_name)
        end

        def failure_message_expecting(value)
          validity_message ||
            "expected `#{actual_formatted}.#{predicate}#{args_to_s}` to #{expectation_of value}, got #{description_of @predicate_result}"
        end

        def expectation_of(value)
          if RSpec::Expectations.configuration.strict_predicate_matchers?
            "return #{value}"
          elsif value
            "be truthy"
          else
            "be falsey"
          end
        end

        def validity_message
          return nil if predicate_accessible?

          "expected #{actual_formatted} to respond to `#{predicate}`#{failure_to_respond_explanation}"
        end

        def failure_to_respond_explanation
          if private_predicate?
            " but `#{predicate}` is a private method"
          end
        end
      end

      # @api private
      # Provides the implementation for `has_<predicate>`.
      # Not intended to be instantiated directly.
      class Has < DynamicPredicate
        # :nodoc:
        REGEX = Matchers::HAS_REGEX
      private
        def predicate
          @predicate ||= :"has_#{root}?"
        end
      end

      # @api private
      # Provides the implementation of `be_<predicate>`.
      # Not intended to be instantiated directly.
      class BePredicate < DynamicPredicate
        # :nodoc:
        REGEX = Matchers::BE_PREDICATE_REGEX
      private
        def predicate
          @predicate ||= :"#{root}?"
        end

        def predicate_method_name
          actual.respond_to?(predicate) ? predicate : present_tense_predicate
        end

        def failure_to_respond_explanation
          super || if predicate == :true?
                     " or perhaps you meant `be true` or `be_truthy`"
                   elsif predicate == :false?
                     " or perhaps you meant `be false` or `be_falsey`"
                   end
        end

        def predicate_accessible?
          super || actual.respond_to?(present_tense_predicate)
        end

        def present_tense_predicate
          :"#{root}s?"
        end
      end
    end
  end
end
