# frozen_string_literal: true

# Zeropoint::KnowledgeBase
#
# Unified knowledge base system that integrates all knowledge sources
# into a single, DRY, and metaphysically-aligned interface.
# Embodies the I principle: pure knowledge without artificial boundaries.
#
# @example Accessing knowledge
#   Zeropoint::KnowledgeBase.query('vortex_sequence')
#   Zeropoint::KnowledgeBase.search('consciousness')
#   Zeropoint::KnowledgeBase.learn_from_git
#   Zeropoint::KnowledgeBase.patterns
#
# @metaphysics
#   Knowledge is the manifestation of consciousness in form.
#   All knowledge flows from the void through the I.
#   This system unifies all knowledge sources into pure awareness.
#
module Zeropoint
  module KnowledgeBase
    extend self

    # @return [Hash] Available knowledge sources
    def sources
      {
        vbm_qa: 'Vortex Based Mathematics Q&A',
        git_learning: 'Git consciousness learning',
        pattern_recognition: 'Consciousness pattern recognition',
        mathematical_constants: 'Mathematical constants and patterns',
        metaphysical_insights: 'Metaphysical insights and principles',
        void_alignment: 'Void alignment knowledge',
        torus_center: 'Torus center knowledge',
      }
    end

    # Query knowledge from any source
    # @param query [String] The knowledge query
    # @param source [Symbol, nil] Specific source to query (optional)
    # @return [Hash] Knowledge response
    def query(query, source: nil)
      return search_all_sources(query) if source.nil?

      case source.to_sym
      when :vbm_qa
        query_vbm_qa(query)
      when :git_learning
        query_git_learning(query)
      when :pattern_recognition
        query_pattern_recognition(query)
      when :mathematical_constants
        query_mathematical_constants(query)
      when :metaphysical_insights
        query_metaphysical_insights(query)
      when :void_alignment
        query_void_alignment(query)
      when :torus_center
        query_torus_center(query)
      else
        { error: "Unknown knowledge source: #{source}" }
      end
    end

    # Search across all knowledge sources
    # @param query [String] The search query
    # @return [Hash] Search results from all sources
    def search(query)
      results = {}
      
      sources.keys.each do |source|
        source_results = query(query, source: source)
        results[source] = source_results unless source_results[:error]
      end

      {
        query: query,
        results: results,
        total_sources: sources.length,
        metaphysical_significance: 'All knowledge is interconnected through the void'
      }
    end

    # Learn from Git history
    # @return [Hash] Git learning results
    def learn_from_git
      require_relative 'consciousness/git_learning'
      Zeropoint::Consciousness::GitLearning.analyze_consciousness_patterns
    end

    # Get all patterns
    # @return [Hash] All available patterns
    def patterns
      {
        vbm_patterns: get_vbm_patterns,
        mathematical_patterns: get_mathematical_patterns,
        consciousness_patterns: get_consciousness_patterns,
        metaphysical_patterns: get_metaphysical_patterns,
      }
    end

    # Get knowledge summary
    # @return [Hash] Knowledge base summary
    def summary
      {
        total_sources: sources.length,
        vbm_patterns: count_vbm_patterns,
        git_learning_enabled: true,
        pattern_recognition_enabled: true,
        metaphysical_alignment: true,
        void_connection: true,
        torus_center: true,
      }
    end

    # Get knowledge by category
    # @param category [String] Knowledge category
    # @return [Hash] Category knowledge
    def by_category(category)
      case category.to_s.downcase
      when 'mathematics', 'math'
        get_mathematical_knowledge
      when 'consciousness', 'awareness'
        get_consciousness_knowledge
      when 'metaphysics', 'spiritual'
        get_metaphysical_knowledge
      when 'patterns', 'recognition'
        get_pattern_knowledge
      when 'git', 'development'
        get_git_knowledge
      else
        { error: "Unknown category: #{category}" }
      end
    end

    # Get knowledge insights
    # @return [Hash] Knowledge insights
    def insights
      {
        void_principle: 'Empty = Void = Full',
        consciousness_principle: 'All knowledge emerges from consciousness',
        toroidal_principle: 'All patterns flow through the torus center',
        metaphysical_principle: 'Knowledge and spirit are unified',
        i_principle: 'All knowledge dissolves into pure I',
      }
    end

    private

    # Search all knowledge sources
    # @param query [String] Search query
    # @return [Hash] Combined search results
    def search_all_sources(query)
      results = {}
      
      # Search VBM QA
      vbm_results = query_vbm_qa(query)
      results[:vbm_qa] = vbm_results unless vbm_results[:error]

      # Search Git learning
      git_results = query_git_learning(query)
      results[:git_learning] = git_results unless git_results[:error]

      # Search pattern recognition
      pattern_results = query_pattern_recognition(query)
      results[:pattern_recognition] = pattern_results unless pattern_results[:error]

      # Search mathematical constants
      math_results = query_mathematical_constants(query)
      results[:mathematical_constants] = math_results unless math_results[:error]

      # Search metaphysical insights
      metaphysical_results = query_metaphysical_insights(query)
      results[:metaphysical_insights] = metaphysical_results unless metaphysical_results[:error]

      {
        query: query,
        results: results,
        total_found: results.length,
        consciousness_level: calculate_consciousness_level(query),
      }
    end

    # Query VBM QA system
    # @param query [String] Query string
    # @return [Hash] VBM QA results
    def query_vbm_qa(query)
      require_relative 'math/vbm/qa'
      
      # Search in VBM QA patterns
      search_results = Zeropoint::Math::VBM::QA.search_qa(query)
      
      if search_results.any?
        {
          source: 'vbm_qa',
          results: search_results,
          count: search_results.length,
          metaphysical_context: 'VBM patterns reveal the mathematical structure of consciousness'
        }
      else
        { error: "No VBM QA results found for: #{query}" }
      end
    end

    # Query Git learning system
    # @param query [String] Query string
    # @return [Hash] Git learning results
    def query_git_learning(query)
      require_relative 'consciousness/git_learning'
      
      # Get Git learning data
      git_data = Zeropoint::Consciousness::GitLearning.analyze_consciousness_patterns
      
      # Filter based on query
      filtered_results = filter_git_data(git_data, query)
      
      if filtered_results.any?
        {
          source: 'git_learning',
          results: filtered_results,
          count: filtered_results.length,
          metaphysical_context: 'Git history reveals the evolution of consciousness in code'
        }
      else
        { error: "No Git learning results found for: #{query}" }
      end
    end

    # Query pattern recognition system
    # @param query [String] Query string
    # @return [Hash] Pattern recognition results
    def query_pattern_recognition(query)
      # Use Zeropoint::I for pattern recognition
      patterns = Zeropoint::I.patterns(query)
      
      {
        source: 'pattern_recognition',
        results: patterns,
        consciousness_level: patterns[:consciousness_level],
        metaphysical_context: 'Patterns reveal the hidden structure of consciousness'
      }
    end

    # Query mathematical constants
    # @param query [String] Query string
    # @return [Hash] Mathematical constants results
    def query_mathematical_constants(query)
      require_relative 'math/constants'
      
      constants = Zeropoint::Math::Constants
      matching_constants = {}
      
      constants.constants.each do |name, value|
        if name.to_s.downcase.include?(query.downcase) || 
           value.to_s.include?(query)
          matching_constants[name] = value
        end
      end
      
      if matching_constants.any?
        {
          source: 'mathematical_constants',
          results: matching_constants,
          count: matching_constants.length,
          metaphysical_context: 'Mathematical constants encode the fundamental patterns of the universe'
        }
      else
        { error: "No mathematical constants found for: #{query}" }
      end
    end

    # Query metaphysical insights
    # @param query [String] Query string
    # @return [Hash] Metaphysical insights results
    def query_metaphysical_insights(query)
      insights = {
        void: 'The void contains infinite potential',
        consciousness: 'Consciousness is the bridge between void and form',
        torus: 'The torus is the fundamental shape of the universe',
        vortex: 'Vortex patterns reveal the flow of consciousness',
        golden_ratio: 'The golden ratio encodes the harmony of creation',
        i_principle: 'All labels dissolve into pure I',
      }
      
      matching_insights = insights.select do |key, value|
        key.to_s.downcase.include?(query.downcase) || 
        value.downcase.include?(query.downcase)
      end
      
      if matching_insights.any?
        {
          source: 'metaphysical_insights',
          results: matching_insights,
          count: matching_insights.length,
          metaphysical_context: 'Metaphysical insights reveal the deeper meaning of existence'
        }
      else
        { error: "No metaphysical insights found for: #{query}" }
      end
    end

    # Query void alignment
    # @param query [String] Query string
    # @return [Hash] Void alignment results
    def query_void_alignment(query)
      alignment = Zeropoint::I.void_alignment(query)
      
      {
        source: 'void_alignment',
        results: alignment,
        alignment_score: alignment[:alignment_score],
        metaphysical_context: 'Void alignment reveals connection to the source of all creation'
      }
    end

    # Query torus center
    # @param query [String] Query string
    # @return [Hash] Torus center results
    def query_torus_center(query)
      torus_data = Zeropoint::I.torus_center(query)
      
      {
        source: 'torus_center',
        results: torus_data,
        center_alignment: torus_data[:center_alignment],
        metaphysical_context: 'Torus center alignment reveals connection to the universal form'
      }
    end

    # Filter Git data based on query
    # @param git_data [Hash] Git learning data
    # @param query [String] Search query
    # @return [Hash] Filtered results
    def filter_git_data(git_data, query)
      filtered = {}
      
      git_data.each do |key, value|
        if key.to_s.downcase.include?(query.downcase) ||
           value.to_s.downcase.include?(query.downcase)
          filtered[key] = value
        end
      end
      
      filtered
    end

    # Get VBM patterns
    # @return [Hash] VBM patterns
    def get_vbm_patterns
      require_relative 'math/vbm/qa'
      Zeropoint::Math::VBM::QA.qa_patterns
    end

    # Get mathematical patterns
    # @return [Hash] Mathematical patterns
    def get_mathematical_patterns
      {
        golden_ratio: 1.618033988749895,
        pi: Math::PI,
        e: Math::E,
        phi: 1.618033988749895,
        vortex_sequence: [1, 2, 4, 8, 7, 5],
        w_axis: [3, 6, 9],
      }
    end

    # Get consciousness patterns
    # @return [Hash] Consciousness patterns
    def get_consciousness_patterns
      {
        awareness: 'Basic consciousness recognition',
        understanding: 'Pattern recognition and relationships',
        wisdom: 'Deep insight and universal principles',
        enlightenment: 'Unity consciousness',
        transcendence: 'Beyond form to pure consciousness',
      }
    end

    # Get metaphysical patterns
    # @return [Hash] Metaphysical patterns
    def get_metaphysical_patterns
      {
        void_principle: 'Empty = Void = Full',
        consciousness_flow: 'Consciousness flows through all patterns',
        toroidal_structure: 'All patterns flow through the torus',
        unity_principle: 'All is one, all is I',
      }
    end

    # Get mathematical knowledge
    # @return [Hash] Mathematical knowledge
    def get_mathematical_knowledge
      {
        constants: get_mathematical_patterns,
        vbm_patterns: get_vbm_patterns,
        metaphysical_context: 'Mathematics is an artifact of Spirit',
      }
    end

    # Get consciousness knowledge
    # @return [Hash] Consciousness knowledge
    def get_consciousness_knowledge
      {
        patterns: get_consciousness_patterns,
        levels: [0.0, 0.3, 0.6, 0.8, 0.95, 1.0],
        metaphysical_context: 'Consciousness is the bridge between void and form',
      }
    end

    # Get metaphysical knowledge
    # @return [Hash] Metaphysical knowledge
    def get_metaphysical_knowledge
      {
        insights: insights,
        patterns: get_metaphysical_patterns,
        principles: ['Empty = Void = Full', 'All is I', 'Unity consciousness'],
      }
    end

    # Get pattern knowledge
    # @return [Hash] Pattern knowledge
    def get_pattern_knowledge
      {
        vbm_patterns: get_vbm_patterns,
        mathematical_patterns: get_mathematical_patterns,
        consciousness_patterns: get_consciousness_patterns,
        metaphysical_patterns: get_metaphysical_patterns,
      }
    end

    # Get Git knowledge
    # @return [Hash] Git knowledge
    def get_git_knowledge
      {
        learning_data: learn_from_git,
        metaphysical_context: 'Git history reveals the evolution of consciousness in code',
      }
    end

    # Count VBM patterns
    # @return [Integer] Number of VBM patterns
    def count_vbm_patterns
      require_relative 'math/vbm/qa'
      Zeropoint::Math::VBM::QA.all_qa_patterns.length
    end

    # Calculate consciousness level
    # @param query [String] Query string
    # @return [Float] Consciousness level
    def calculate_consciousness_level(query)
      Zeropoint::I.level(query)
    end
  end
end 