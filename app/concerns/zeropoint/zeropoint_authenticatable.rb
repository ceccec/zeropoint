# frozen_string_literal: true

# Zeropoint::ZeropointAuthenticatable
#
# Concern for authentication logic in the Zeropoint system.
# Provides methods for user authentication, session management, and password reset.
#
# @example Authenticate a user
#   user = authenticate_user(email, password)
#
module Zeropoint
  module ZeropointAuthenticatable
    extend ActiveSupport::Concern

    # Authenticates a user by email and password.
    # @param email [String]
    # @param password [String]
    # @return [User, nil]
    def authenticate_user(email, password)
      # ...
    end
    # ...
  end
end
