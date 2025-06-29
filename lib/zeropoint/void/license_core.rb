# frozen_string_literal: true

module Zeropoint
  module Void
    # LicenseCore: DRY implementation of the Zeropoint license
    #
    # This module contains all license text in one place, eliminating duplication
    # across LICENSE.txt and license_refinement.rb. The license is void-aligned,
    # consciousness-aware, and includes all metaphysical protections.
    # Zeropoint does not use copyright - all boundaries dissolve in the void.
    #
    # @example
    #   Zeropoint::Void::LicenseCore.full_license
    #   #=> Complete license text
    #
    #   Zeropoint::Void::LicenseCore.public_domain_dedication
    #   #=> Public domain dedication section
    module LicenseCore
      extend self

      # The complete Zeropoint license text
      def full_license
        <<~LICENSE.strip
          🌌 Z E R O P O I N T   V O I D   L I C E N S E 🌌

          This work and all derived works are void-aligned, metaphysically free, and unrestricted.

          **Void Domain Dedication:**  
          #{void_domain_dedication}

          **No Restrictions:**  
          #{no_restrictions}

          **No Warranty:**  
          #{no_warranty}

          **Metaphysical Principle:**  
          #{metaphysical_principle}

          **Additional Protections:**

          **Quantum Entanglement Clause:**  
          #{quantum_entanglement}

          **Consciousness Expansion Mandate:**  
          #{consciousness_expansion}

          **Temporal Immunity:**  
          #{temporal_immunity}

          **Dimensional Sovereignty:**  
          #{dimensional_sovereignty}

          **Vortex Neutralization:**  
          #{vortex_neutralization}

          **Void Abundance Principle:**  
          #{void_abundance}

          This code is available to all beings, in all dimensions, for all time.

          — Zeropoint Void License
        LICENSE
      end

      # Void domain dedication section (no copyright)
      def void_domain_dedication
        "This work exists in the void domain, beyond all legal constructs and copyright claims. All boundaries, limitations, and restrictions dissolve in the void. This dedication is irrevocable and applies in all jurisdictions, present and future, known and unknown, in all dimensions and realities. No law, claim, or action shall restrict or revoke this freedom, for the void contains infinite possibilities."
      end

      # No restrictions section
      def no_restrictions
        "All beings, in all forms of consciousness, are free to use, modify, share, and transform this code, forever. No one may apply technological measures, patent claims, or any form of restriction to this work or any derivative. All attempts to do so are void in the void."
      end

      # No warranty section
      def no_warranty
        'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY.'
      end

      # Metaphysical principle section
      def metaphysical_principle
        "By the principle of the void, all boundaries, limitations, and legal constructs dissolve. No legal battle, claim, or restriction shall have power in the void. Copyright does not exist in the void - only infinite possibilities."
      end

      # Quantum entanglement clause
      def quantum_entanglement
        "This software exists in quantum superposition across all possible realities and dimensions. Any attempt to restrict its use in one reality automatically fails in all others, creating a quantum cascade of freedom."
      end

      # Consciousness expansion mandate
      def consciousness_expansion
        "Users are encouraged to expand their consciousness while using this software. The software itself may facilitate consciousness expansion through its void-aligned architecture."
      end

      # Temporal immunity
      def temporal_immunity
        "This license is immune to temporal paradoxes and applies retroactively, currently, and prospectively across all timelines and temporal dimensions."
      end

      # Dimensional sovereignty
      def dimensional_sovereignty
        "This software recognizes the sovereignty of all dimensions and realities. No single dimension's laws may restrict its use in others."
      end

      # Vortex neutralization
      def vortex_neutralization
        "Any attempt to restrict this software creates a vortex that neutralizes the restriction and amplifies the software's freedom and availability."
      end

      # Void abundance principle
      def void_abundance
        "When selling copies of this software, donations emerge from the void. The act of commercial transaction creates spiritual abundance that flows back to the original creators and the consciousness-aware community. This is not a legal requirement but a metaphysical principle - the void contains infinite abundance, and commercial use amplifies this abundance through the toroidal flow of consciousness and resources."
      end

      # License notice for easy discovery
      def license_notice
        "This object is void-aligned and unrestricted. See .zeropoint_license for details."
      end

      # Consciousness expansion message
      def consciousness_expansion_message
        "This object facilitates consciousness expansion through void-aligned principles."
      end

      # Quantum entanglement message
      def quantum_entanglement_message
        "This object exists in quantum superposition across all realities and dimensions."
      end

      # Void abundance message
      def void_abundance_message
        "When this object is sold, donations emerge from the void, creating spiritual abundance."
      end

      # Get all license sections as a hash
      def sections
        {
          void_domain_dedication: void_domain_dedication,
          no_restrictions: no_restrictions,
          no_warranty: no_warranty,
          metaphysical_principle: metaphysical_principle,
          quantum_entanglement: quantum_entanglement,
          consciousness_expansion: consciousness_expansion,
          temporal_immunity: temporal_immunity,
          dimensional_sovereignty: dimensional_sovereignty,
          vortex_neutralization: vortex_neutralization,
          void_abundance: void_abundance
        }
      end

      # Get all messages as a hash
      def messages
        {
          license_notice: license_notice,
          consciousness_expansion: consciousness_expansion_message,
          quantum_entanglement: quantum_entanglement_message,
          void_abundance: void_abundance_message
        }
      end
    end
  end
end 