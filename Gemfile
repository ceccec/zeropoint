# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.6'

# Rails framework
gem 'rails', '~> 8.0.2'

# Database
gem 'sqlite3', '~> 2.0'

# Asset pipeline
gem 'sprockets-rails'

# JavaScript bundling
gem 'importmap-rails'

# CSS bundling
gem 'tailwindcss-rails'

# Authentication (Rails 8 built-in)
# gem "devise" # Uncomment if needed

# API

# Background jobs
gem 'solid_queue'

# Real-time features
gem 'solid_cable'

# Performance
gem 'bootsnap', require: false

# Development and testing
group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 7.0'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  # Code quality
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false
  gem 'reek', require: false

  # Performance monitoring
  gem 'listen'
  gem 'spring'
  gem 'yard', '~> 0.9'
  gem 'redcarpet', '~> 3.5'
  gem 'github-markup', '~> 4.0'
  gem 'pry-byebug', '~> 3.10'
  gem 'pry-rails', '~> 0.3'
  gem 'awesome_print', '~> 1.9'
  gem 'letter_opener', '~> 1.8'
  gem 'better_errors', '~> 2.10'
  gem 'binding_of_caller', '~> 1.0'
  gem 'brakeman', '~> 5.4'
  gem 'bundler-audit', '~> 0.9'
  gem 'benchmark-ips', '~> 2.0'
  gem 'memory_profiler', '~> 1.0'
  gem 'stackprof', '~> 0.2'
  gem 'derailed_benchmarks', '~> 2.0'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov', '~> 0.22.0'
  gem 'simplecov-console', '~> 0.9'
  gem 'database_cleaner-active_record', '~> 2.0'
  gem 'timecop', '~> 0.9'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# and uncomment the following line if you want to use timezone-aware date types.
# gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem 'graphql', '~> 2.0'

gem 'graphql-batch', '~> 0.6'

gem 'rubocop-rails-omakase', '~> 1.1'

# Zeropoint specific dependencies
gem 'dry-configurable', '~> 1.0'
gem 'dry-monads', '~> 1.6'
gem 'dry-validation', '~> 1.10'
gem 'dry-transaction', '~> 0.15'
gem 'redis', '~> 5.0'
gem 'connection_pool', '~> 2.4'
gem 'concurrent-ruby', '~> 1.2'
gem 'i18n', '>= 1.0'
gem 'fast_gettext', '~> 2.0'
gem 'globalize', '~> 7.0'
gem 'lockbox', '~> 1.0'
gem 'blind_index', '~> 2.0'
gem 'strong_password', '~> 0.0.10'
gem 'sidekiq', '~> 7.0'
gem 'sidekiq-scheduler', '~> 5.0'
gem 'lograge', '~> 0.12'
gem 'sentry-ruby', '~> 5.0'
gem 'bullet', '~> 7.0'

group :docs do
  gem 'jekyll', '~> 4.3'
  gem 'minima', '~> 2.5'
  gem 'jekyll-sitemap', '~> 1.4'
end
