# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.5.1'
gem 'i18n'
gem 'require_all', '~> 2.0'
gem 'terminal-table'

group :development do
  gem 'fasterer'
  gem 'pry'
  gem 'rubocop', require: false
end

group :test do
  gem "rspec", "~> 3.7"
  gem 'simplecov', require: false, group: :test
end
