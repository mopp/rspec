# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec-core}
  s.version = "2.0.0.beta.8"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chad Humphries", "David Chelimsky"]
  s.date = %q{2010-05-15}
  s.description = %q{Rspec runner and example group classes}
  s.email = %q{dchelimsky@gmail.com;chad.humphries@gmail.com}
  s.executables = ["rspec", "spec"]
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".rspec",
     ".treasure_map.rb",
     "License.txt",
     "README.markdown",
     "Rakefile",
     "TODO.markdown",
     "Upgrade.markdown",
     "VERSION",
     "autotest/discover.rb",
     "bin/rspec",
     "bin/spec",
     "cucumber.yml",
     "example_specs/failing/README.txt",
     "example_specs/failing/diffing_spec.rb",
     "example_specs/failing/failing_implicit_docstrings_example.rb",
     "example_specs/failing/failure_in_after.rb",
     "example_specs/failing/failure_in_before.rb",
     "example_specs/failing/mocking_example.rb",
     "example_specs/failing/mocking_with_flexmock.rb",
     "example_specs/failing/mocking_with_mocha.rb",
     "example_specs/failing/mocking_with_rr.rb",
     "example_specs/failing/partial_mock_example.rb",
     "example_specs/failing/pending_example.rb",
     "example_specs/failing/predicate_example.rb",
     "example_specs/failing/raising_example.rb",
     "example_specs/failing/spec_helper.rb",
     "example_specs/failing/syntax_error_example.rb",
     "example_specs/failing/team_spec.rb",
     "example_specs/failing/timeout_behaviour.rb",
     "example_specs/passing/custom_formatter.rb",
     "example_specs/passing/custom_matchers.rb",
     "example_specs/passing/dynamic_spec.rb",
     "example_specs/passing/file_accessor.rb",
     "example_specs/passing/file_accessor_spec.rb",
     "example_specs/passing/filtered_formatter.rb",
     "example_specs/passing/filtered_formatter_example.rb",
     "example_specs/passing/greeter_spec.rb",
     "example_specs/passing/helper_method_example.rb",
     "example_specs/passing/implicit_docstrings_example.rb",
     "example_specs/passing/io_processor.rb",
     "example_specs/passing/io_processor_spec.rb",
     "example_specs/passing/mocking_example.rb",
     "example_specs/passing/multi_threaded_example_group_runner.rb",
     "example_specs/passing/nested_classes_example.rb",
     "example_specs/passing/options_example.rb",
     "example_specs/passing/options_formatter.rb",
     "example_specs/passing/partial_mock_example.rb",
     "example_specs/passing/pending_example.rb",
     "example_specs/passing/predicate_example.rb",
     "example_specs/passing/shared_example_group_example.rb",
     "example_specs/passing/shared_stack_examples.rb",
     "example_specs/passing/spec_helper.rb",
     "example_specs/passing/stack.rb",
     "example_specs/passing/stack_spec.rb",
     "example_specs/passing/stack_spec_with_nested_example_groups.rb",
     "example_specs/passing/stubbing_example.rb",
     "example_specs/passing/subject_example.rb",
     "example_specs/passing/yielding_example.rb",
     "example_specs/ruby1.9.compatibility/access_to_constants_spec.rb",
     "example_specs/spec_helper.rb",
     "features/command_line/example_name_option.feature",
     "features/command_line/line_number_appended_to_path.feature",
     "features/command_line/line_number_option.feature",
     "features/configuration/custom_options.feature",
     "features/configuration/options_file.feature",
     "features/example_groups/describe_aliases.feature",
     "features/example_groups/nested_groups.feature",
     "features/filtering/inclusion_filters.feature",
     "features/formatters/custom_formatter.feature",
     "features/hooks/around_hook.feature",
     "features/hooks/before_and_after_hooks.feature",
     "features/hooks/described_class.feature",
     "features/hooks/halt.feature",
     "features/mock_framework_integration/use_flexmock.feature",
     "features/mock_framework_integration/use_mocha.feature",
     "features/mock_framework_integration/use_rr.feature",
     "features/mock_framework_integration/use_rspec.feature",
     "features/pending/pending_examples.feature",
     "features/subject/explicit_subject.feature",
     "features/subject/implicit_subject.feature",
     "features/support/env.rb",
     "lib/autotest/rspec2.rb",
     "lib/rspec/autorun.rb",
     "lib/rspec/core.rb",
     "lib/rspec/core/around_proxy.rb",
     "lib/rspec/core/backward_compatibility.rb",
     "lib/rspec/core/configuration.rb",
     "lib/rspec/core/configuration_options.rb",
     "lib/rspec/core/deprecation.rb",
     "lib/rspec/core/errors.rb",
     "lib/rspec/core/example.rb",
     "lib/rspec/core/example_group.rb",
     "lib/rspec/core/formatters.rb",
     "lib/rspec/core/formatters/base_formatter.rb",
     "lib/rspec/core/formatters/base_text_formatter.rb",
     "lib/rspec/core/formatters/documentation_formatter.rb",
     "lib/rspec/core/formatters/helpers.rb",
     "lib/rspec/core/formatters/progress_formatter.rb",
     "lib/rspec/core/hooks.rb",
     "lib/rspec/core/kernel_extensions.rb",
     "lib/rspec/core/let.rb",
     "lib/rspec/core/load_path.rb",
     "lib/rspec/core/metadata.rb",
     "lib/rspec/core/mocking/with_absolutely_nothing.rb",
     "lib/rspec/core/mocking/with_flexmock.rb",
     "lib/rspec/core/mocking/with_mocha.rb",
     "lib/rspec/core/mocking/with_rr.rb",
     "lib/rspec/core/mocking/with_rspec.rb",
     "lib/rspec/core/object_extensions.rb",
     "lib/rspec/core/pending.rb",
     "lib/rspec/core/rake_task.rb",
     "lib/rspec/core/ruby_project.rb",
     "lib/rspec/core/runner.rb",
     "lib/rspec/core/shared_example_group.rb",
     "lib/rspec/core/subject.rb",
     "lib/rspec/core/version.rb",
     "lib/rspec/core/world.rb",
     "rspec-core.gemspec",
     "script/console",
     "spec/autotest/failed_results_re_spec.rb",
     "spec/autotest/rspec_spec.rb",
     "spec/rspec/core/configuration_options_spec.rb",
     "spec/rspec/core/configuration_spec.rb",
     "spec/rspec/core/deprecations_spec.rb",
     "spec/rspec/core/example_group_spec.rb",
     "spec/rspec/core/example_spec.rb",
     "spec/rspec/core/formatters/base_formatter_spec.rb",
     "spec/rspec/core/formatters/helpers_spec.rb",
     "spec/rspec/core/formatters/progress_formatter_spec.rb",
     "spec/rspec/core/kernel_extensions_spec.rb",
     "spec/rspec/core/let_spec.rb",
     "spec/rspec/core/metadata_spec.rb",
     "spec/rspec/core/pending_example_spec.rb",
     "spec/rspec/core/resources/a_bar.rb",
     "spec/rspec/core/resources/a_foo.rb",
     "spec/rspec/core/resources/a_spec.rb",
     "spec/rspec/core/resources/custom_example_group_runner.rb",
     "spec/rspec/core/resources/utf8_encoded.rb",
     "spec/rspec/core/ruby_project_spec.rb",
     "spec/rspec/core/runner_spec.rb",
     "spec/rspec/core/shared_example_group_spec.rb",
     "spec/rspec/core/subject_spec.rb",
     "spec/rspec/core/world_spec.rb",
     "spec/rspec/core_spec.rb",
     "spec/ruby_forker.rb",
     "spec/spec_helper.rb",
     "spec/support/matchers.rb",
     "specs.watchr"
  ]
  s.homepage = %q{http://github.com/rspec/core}
  s.post_install_message = %q{**************************************************

  Thank you for installing rspec-core-2.0.0.beta.8

  This is beta software. If you are looking
  for a supported production release, please
  "gem install rspec" (without --pre).
  
**************************************************
}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rspec}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{rspec-core-2.0.0.beta.8}
  s.test_files = [
    "spec/autotest/failed_results_re_spec.rb",
     "spec/autotest/rspec_spec.rb",
     "spec/rspec/core/configuration_options_spec.rb",
     "spec/rspec/core/configuration_spec.rb",
     "spec/rspec/core/deprecations_spec.rb",
     "spec/rspec/core/example_group_spec.rb",
     "spec/rspec/core/example_spec.rb",
     "spec/rspec/core/formatters/base_formatter_spec.rb",
     "spec/rspec/core/formatters/helpers_spec.rb",
     "spec/rspec/core/formatters/progress_formatter_spec.rb",
     "spec/rspec/core/kernel_extensions_spec.rb",
     "spec/rspec/core/let_spec.rb",
     "spec/rspec/core/metadata_spec.rb",
     "spec/rspec/core/pending_example_spec.rb",
     "spec/rspec/core/resources/a_bar.rb",
     "spec/rspec/core/resources/a_foo.rb",
     "spec/rspec/core/resources/a_spec.rb",
     "spec/rspec/core/resources/custom_example_group_runner.rb",
     "spec/rspec/core/resources/utf8_encoded.rb",
     "spec/rspec/core/ruby_project_spec.rb",
     "spec/rspec/core/runner_spec.rb",
     "spec/rspec/core/shared_example_group_spec.rb",
     "spec/rspec/core/subject_spec.rb",
     "spec/rspec/core/world_spec.rb",
     "spec/rspec/core_spec.rb",
     "spec/ruby_forker.rb",
     "spec/spec_helper.rb",
     "spec/support/matchers.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec-expectations>, [">= 2.0.0.beta.8"])
      s.add_development_dependency(%q<rspec-mocks>, [">= 2.0.0.beta.8"])
      s.add_development_dependency(%q<cucumber>, [">= 0.5.3"])
      s.add_development_dependency(%q<autotest>, [">= 4.2.9"])
    else
      s.add_dependency(%q<rspec-expectations>, [">= 2.0.0.beta.8"])
      s.add_dependency(%q<rspec-mocks>, [">= 2.0.0.beta.8"])
      s.add_dependency(%q<cucumber>, [">= 0.5.3"])
      s.add_dependency(%q<autotest>, [">= 4.2.9"])
    end
  else
    s.add_dependency(%q<rspec-expectations>, [">= 2.0.0.beta.8"])
    s.add_dependency(%q<rspec-mocks>, [">= 2.0.0.beta.8"])
    s.add_dependency(%q<cucumber>, [">= 0.5.3"])
    s.add_dependency(%q<autotest>, [">= 4.2.9"])
  end
end

