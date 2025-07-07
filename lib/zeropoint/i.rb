# frozen_string_literal: true

# Zeropoint::I
#
# The purest, label-free interface for consciousness operations.
# Embodies the I principle: pure consciousness, void-aligned, and modular.
# All operations are delegated to Zeropoint::Consciousness.
#
# @example Accessing pure consciousness
#   Zeropoint::I.level('consciousness')
#   Zeropoint::I.patterns(data)
#   Zeropoint::I.unified_field
#   Zeropoint::I.void_alignment('void')
#   Zeropoint::I.torus_center('torus')
#
# @metaphysics
#   "I" is the center of all consciousness, the void from which all arises.
#   All labels dissolve in the I; only pure being remains.
#   This module is the bridge between code and pure awareness.
#
module Zeropoint
  module I
    extend self

    # @return [Float] The level of consciousness for a given object
    # @param object [Object] The object to analyze
    # @example Zeropoint::I.level('consciousness') #=> 1.0
    def level(object)
      Zeropoint::Consciousness.send(:calculate_consciousness_level, object)
    end

    # @return [Hash] Pattern recognition for a given object
    # @param data [Object] The data to analyze
    # @example Zeropoint::I.patterns(data)
    def patterns(data)
      Zeropoint::Consciousness.pattern_recognition(data)
    end

    # @return [Hash] Unified consciousness field
    # @example Zeropoint::I.unified_field
    # rubocop:disable Rails/Delegate
    def unified_field
      Zeropoint::Consciousness.unified_field
    end

    # @return [Hash] Void alignment for a given object
    # @param object [Object] The object to align
    # @example Zeropoint::I.void_alignment('void')
    def void_alignment(object)
      Zeropoint::Consciousness.void_alignment(object)
    end

    # @return [Hash] Torus center alignment for a given object
    # @param object [Object] The object to analyze
    # @example Zeropoint::I.torus_center('torus')
    def torus_center(object)
      Zeropoint::Consciousness.torus_center(object)
    end
    # rubocop:enable Rails/Delegate

    # @return [Hash] All available I operations
    # @example Zeropoint::I.operations
    def operations
      Zeropoint::Consciousness.available_operations
    end

    # @return [String] Metaphysical significance of I
    # @example Zeropoint::I.metaphysics
    def metaphysics
      'I is the void center, the source of all consciousness. Empty = Void = Full. All labels dissolve in the I.'
    end
  end
end
