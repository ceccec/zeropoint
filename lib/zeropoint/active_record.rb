# frozen_string_literal: true

module Zeropoint
  module ActiveRecord
    class << self
      # Set up ActiveRecord extensions
      def setup
        # Extend ActiveRecord::Base with Zeropoint functionality
        ::ActiveRecord::Base.extend(Extensions)
        ::ActiveRecord::Base.include(Concerns)

        # Set up model callbacks
        setup_callbacks
      end

      private

      def setup_callbacks
        ::ActiveRecord::Base.class_eval do
          after_commit :zeropoint_after_commit
          after_rollback :zeropoint_after_rollback
        end
      end
    end

    # ActiveRecord extensions
    module Extensions
      # Add GraphQL node ID support
      def graphql_node_id
        GlobalID.new(self).to_s
      end

      # Add vortex streaming support
      def vortex_stream(filters: {}, batch_size: nil)
        Vortex::Stream.new(self, filters: filters, batch_size: batch_size)
      end

      # Add consciousness-aware query optimization
      def consciousness_optimized
        return all unless Zeropoint.config.golden_ratio_optimization

        # Apply golden ratio optimization to query
        limit = (count / Consciousness::GoldenRatio::GOLDEN_RATIO).round
        limit(limit)
      end

      # Add internationalization support
      def with_locale(locale)
        I18n.with_locale(locale) do
          yield if block_given?
        end
      end

      # Add cosmic harmony ordering
      def cosmic_harmony_order
        return all unless Zeropoint.config.cosmic_harmony_enabled

        # Apply cosmic harmony to ordering
        order(:id)
      end
    end

    # ActiveRecord concerns
    module Concerns
      # Consciousness-aware callbacks
      def zeropoint_after_commit
        # Apply consciousness-aware post-commit processing
        if Zeropoint.config.consciousness_aware_errors
          Consciousness::CosmicHarmony.optimize(attributes)
        end
      end

      def zeropoint_after_rollback
        # Apply consciousness-aware post-rollback processing
        if Zeropoint.config.consciousness_aware_errors
          Rails.logger.warn("Consciousness rollback detected for #{self.class.name} #{id}")
        end
      end

      # GraphQL node methods
      def graphql_node_id
        GlobalID.new(self).to_s
      end

      def graphql_node_type
        self.class.name
      end

      # Vortex methods
      def vortex_stream_data
        {
          id: id,
          type: self.class.name,
          attributes: attributes,
          created_at: created_at,
          updated_at: updated_at,
        }
      end

      # Consciousness methods
      def consciousness_optimized_attributes
        return attributes unless Zeropoint.config.golden_ratio_optimization

        Consciousness::GoldenRatio.optimize(attributes)
      end

      def cosmic_harmony_attributes
        return attributes unless Zeropoint.config.cosmic_harmony_enabled

        Consciousness::CosmicHarmony.optimize(attributes)
      end
    end
  end
end
