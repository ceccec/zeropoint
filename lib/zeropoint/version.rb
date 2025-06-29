# frozen_string_literal: true

module Zeropoint
  # 🌌 Zeropoint Version
  #
  # The current version of the Zeropoint gem.
  # Follows semantic versioning: MAJOR.MINOR.PATCH
  #
  # @see https://semver.org/
  VERSION = '1.0.0'
  MAJOR = 1
  MINOR = 0
  PATCH = 0

  # Version string for display
  def self.version_string
    "v#{VERSION}"
  end

  # Full version information
  def self.full_version
    {
      version: VERSION,
      major: MAJOR,
      minor: MINOR,
      patch: PATCH,
      string: version_string,
    }
  end
end
