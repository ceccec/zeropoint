# frozen_string_literal: true

# Custom RSpec Matchers for DRY, expressive specs

RSpec::Matchers.define :be_defined do
  match do |actual|
    actual.is_a?(Class) || actual.is_a?(Module)
  end
  failure_message do |actual|
    "Expected #{actual} to be a defined class or module"
  end
end

RSpec::Matchers.define :be_present do
  match do |actual|
    !actual.nil? && actual != false
  end
  failure_message do |actual|
    "Expected #{actual} to be present"
  end
end

RSpec::Matchers.define :respond_to_method do |method_name|
  match do |actual|
    actual.respond_to?(method_name)
  end
  failure_message do |actual|
    "Expected #{actual} to respond to #{method_name}"
  end
end

RSpec::Matchers.define :have_key do |key|
  match do |actual|
    actual.is_a?(Hash) && actual.key?(key)
  end
  failure_message do |actual|
    "Expected #{actual} to be a hash with key #{key}"
  end
end

RSpec::Matchers.define :contain_item do |item|
  match do |actual|
    actual.include?(item)
  end
  failure_message do |actual|
    "Expected #{actual} to contain #{item}"
  end
end

RSpec::Matchers.define :be_frozen do
  match(&:frozen?)
  failure_message do |actual|
    "Expected #{actual} to be frozen"
  end
end

RSpec::Matchers.define :be_optimized do
  match do |actual|
    actual.is_a?(Hash) && actual.keys.all? { |k| k.is_a?(String) }
  end
  failure_message do |actual|
    "Expected #{actual} to be optimized (all keys as strings)"
  end
end

RSpec::Matchers.define :be_less_than do |value|
  match do |actual|
    actual < value
  end
  failure_message do |actual|
    "Expected #{actual} to be less than #{value}"
  end
end

RSpec::Matchers.define :be_between do |min, max|
  match do |actual|
    actual >= min && actual <= max
  end
  failure_message do |actual|
    "Expected #{actual} to be between #{min} and #{max}"
  end
end

RSpec::Matchers.define :match_pattern do |pattern|
  match do |actual|
    actual.to_s.match?(pattern)
  end
  failure_message do |actual|
    "Expected #{actual} to match pattern #{pattern}"
  end
end

RSpec::Matchers.define :be_mutable do
  match do |actual|
    !actual.frozen?
  end
  failure_message do |actual|
    "Expected #{actual} to be mutable (not frozen)"
  end
end
