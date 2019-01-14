# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  minimum_coverage 95
end

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end
end

require_relative '../autoload'
