# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../lib/zeropoint/math/vbm'

RSpec.describe Zeropoint::Math::VBM::QA do
  let(:qa) { described_class }

  describe '.qa_pattern' do
    it 'returns complete Q&A for vortex_sequence' do
      result = qa.qa_pattern('vortex_sequence')
      expect(result).to include(
        question: "What is the vortex sequence?",
        answer: include("1-2-4-8-7-5"),
        pattern: [ 1, 2, 4, 8, 7, 5 ],
        metaphysical: include("backbone of all number flow")
      )
    end

    it 'returns nil for non-existent pattern' do
      expect(qa.qa_pattern('nonexistent')).to be_nil
    end
  end

  describe '.search_qa' do
    it 'finds vortex-related patterns' do
      results = qa.search_qa('vortex')
      expect(results.keys).to include('vortex_sequence', 'mobius_circuit')
    end

    it 'finds spirit-related patterns' do
      results = qa.search_qa('spirit')
      expect(results.keys).to include('w_axis', 'harmonic_cascadence')
    end

    it 'returns empty for non-matching query' do
      results = qa.search_qa('xyz123')
      expect(results).to be_empty
    end
  end

  describe '.qa_by_category' do
    it 'returns core patterns' do
      results = qa.qa_by_category('core_patterns')
      expect(results.keys).to include('vortex_sequence', 'w_axis', 'polar_mates', 'family_number_groups')
    end

    it 'returns empty for invalid category' do
      results = qa.qa_by_category('invalid')
      expect(results).to be_empty
    end
  end

  describe '.qa_summary' do
    it 'returns correct statistics' do
      summary = qa.qa_summary
      expect(summary[:total_patterns]).to eq(20)
      expect(summary[:categories]).to include('core_patterns', 'mathematical_operations')
      expect(summary[:metaphysical_contexts]).to eq(20)
    end
  end
end
