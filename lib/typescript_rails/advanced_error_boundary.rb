# frozen_string_literal: true

# Advanced Error Boundary System for TypeScript Rails
# Provides comprehensive error handling with retry, reporting, and Redux integration

module TypeScriptRails
  module AdvancedErrorBoundary
    # Error reporting service interface
    class ErrorReporter
      def self.report(error, context = {})
        # Integration with services like Sentry, Bugsnag, etc.
        if defined?(Sentry)
          Sentry.capture_exception(error, extra: context)
        elsif defined?(Bugsnag)
          Bugsnag.notify(error) do |report|
            report.add_metadata(:context, context)
          end
        else
          Rails.logger.error("Error Boundary: #{error.message}")
          Rails.logger.error("Context: #{context}")
        end
      end
    end

    # Error boundary configuration
    class ErrorBoundaryConfig
      attr_accessor :max_retries, :retry_delay, :enable_reporting, :reporting_service

      def initialize
        @max_retries = 3
        @retry_delay = 1000 # milliseconds
        @enable_reporting = true
        @reporting_service = :sentry
      end
    end

    # Error boundary state management
    class ErrorBoundaryState
      attr_accessor :has_error, :error, :retry_count, :last_retry_time

      def initialize
        @has_error = false
        @error = nil
        @retry_count = 0
        @last_retry_time = nil
      end

      def can_retry?(max_retries)
        @retry_count < max_retries
      end

      def increment_retry
        @retry_count += 1
        @last_retry_time = Time.current
      end

      def reset
        @has_error = false
        @error = nil
        @retry_count = 0
        @last_retry_time = nil
      end
    end

    # Redux error action creators (TypeScript example)
    ERROR_ACTIONS_TS = <<~TYPESCRIPT
      // Redux error action creators (TypeScript)
      export const setError = (error, context = {}) => ({
        type: 'ERROR_BOUNDARY/SET_ERROR',
        payload: {
          error: {
            message: error.message,
            stack: error.stack?.split('\n').slice(0, 5),
            name: error.name
          },
          context,
          timestamp: new Date().toISOString()
        }
      });
      // ... other actions ...
    TYPESCRIPT

    # Error boundary reducer (TypeScript example)
    ERROR_REDUCER_TS = <<~TYPESCRIPT
      // Error boundary reducer (TypeScript)
      function errorReducer(state = initialState, action) {
        switch (action.type) {
          case 'ERROR_BOUNDARY/SET_ERROR':
            return {
              ...state,
              hasError: true,
              error: action.payload.error,
              context: action.payload.context,
              timestamp: action.payload.timestamp
            };
          case 'ERROR_BOUNDARY/CLEAR_ERROR':
            return {
              ...state,
              hasError: false,
              error: null,
              context: null,
              timestamp: null,
              retryCount: 0
            };
          // ...
          default:
            return state;
        }
      }
    TYPESCRIPT

    # Error boundary utilities (Ruby)
    module ErrorUtils
      def self.recoverable_error?(error)
        # Determine if error is recoverable
        recoverable_errors = [ NetworkError, TimeoutError ]
        non_recoverable_errors = [ ValidationError, AuthorizationError ]

        return true if recoverable_errors.any? { |error_class| error.is_a?(error_class) }
        return false if non_recoverable_errors.any? { |error_class| error.is_a?(error_class) }

        # Default to recoverable for unknown errors
        true
      end

      def self.get_error_context(error, component_info = {})
        {
          error_type: error.class.name,
          error_message: error.message,
          component: component_info[:component],
          action: component_info[:action],
          user_id: component_info[:user_id],
          url: component_info[:url],
          user_agent: component_info[:user_agent],
          timestamp: Time.current.iso8601,
        }
      end

      def self.should_retry?(error, retry_count, max_retries)
        return false if retry_count >= max_retries
        return false unless recoverable_error?(error)

        true
      end

      def self.get_retry_delay(retry_count, base_delay = 1000)
        (2**retry_count) * base_delay
      end
    end

    # Error boundary configuration
    class << self
      def configure
        yield configuration
      end

      def configuration
        @configuration ||= ErrorBoundaryConfig.new
      end

      def generate_typescript_error_boundary
        generate_advanced_error_boundary_component
      end

      private

      def generate_advanced_error_boundary_component
        <<~TYPESCRIPT
          // Advanced Error Boundary Component
          import React, { Component, ReactNode } from 'react';
          import { connect } from 'react-redux';
          // ...
          // See Ruby for more details
        TYPESCRIPT
      end
    end
  end
end
