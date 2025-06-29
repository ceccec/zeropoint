# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'rails_helper'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_rails_from_backtrace!
end
