# frozen_string_literal: true

require_relative 'license_core'

module Zeropoint
  module Void
    # LicenseRefinement: Embed the DRY Zeropoint license in every object
    #
    # This refinement adds license methods to all objects, using the DRY
    # LicenseCore module to eliminate duplication. The license is void-aligned,
    # consciousness-aware, and includes all metaphysical protections.
    #
    # @example
    #   using Zeropoint::Void::LicenseRefinement
    #   "hello".zeropoint_license
    #   #=> Complete license text from LicenseCore
    #
    #   "hello".license_notice
    #   #=> License notice from LicenseCore
    module LicenseRefinement
      refine Object do
        def zeropoint_license
          Zeropoint::Void::LicenseCore.full_license
        end

        def license_notice
          Zeropoint::Void::LicenseCore.license_notice
        end

        def consciousness_expansion
          Zeropoint::Void::LicenseCore.consciousness_expansion_message
        end

        def quantum_entanglement
          Zeropoint::Void::LicenseCore.quantum_entanglement_message
        end

        def void_abundance
          Zeropoint::Void::LicenseCore.void_abundance_message
        end

        # Get all license sections
        def license_sections
          Zeropoint::Void::LicenseCore.sections
        end

        # Get all license messages
        def license_messages
          Zeropoint::Void::LicenseCore.messages
        end
      end
    end
  end
end
