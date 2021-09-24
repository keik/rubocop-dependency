# frozen_string_literal: true

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'simplecov-lcov'

  SimpleCov.start do
    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
      c.single_report_path = 'coverage/lcov.info'
    end
    formatter SimpleCov::Formatter::LcovFormatter

    add_filter '/spec/'
  end
end

require 'rubocop-dependency'
require 'rubocop/rspec/support'

RSpec.configure do |config|
  config.include RuboCop::RSpec::ExpectOffense

  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!
  config.raise_on_warning = true
  config.fail_if_no_examples = true

  config.order = :random
  Kernel.srand config.seed
end
