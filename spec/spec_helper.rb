require 'simplecov'

SimpleCov.start do
  minimum_coverage 95
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require_relative '../autoload'
