# frozen_string_literal: true

module Zeropoint
  class AstroBlogController < ApplicationController
    layout false

    def index
      @locale = I18n.locale
      render 'zeropoint/astro_blog/index'
    end

    # API endpoint for blog posts
    def posts
      posts = load_sample_posts

      # Apply filters
      posts = filter_posts(posts, params)

      # Apply pagination
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 6).to_i
      offset = (page - 1) * per_page

      paginated_posts = posts[offset, per_page] || []

      render json: {
        posts: paginated_posts,
        pagination: {
          current_page: page,
          total_pages: (posts.length.to_f / per_page).ceil,
          total_posts: posts.length,
          per_page: per_page,
        },
      }
    end

    # API endpoint for categories
    def categories
      categories = [
        { name: 'consciousness', count: 15, color: 'consciousness' },
        { name: 'vortex', count: 12, color: 'vortex' },
        { name: 'golden-ratio', count: 8, color: 'golden' },
        { name: 'cosmic', count: 20, color: 'cosmic' },
      ]

      render json: { categories: categories }
    end

    # API endpoint for tags
    def tags
      tags = [
        { name: 'consciousness', count: 25 },
        { name: 'unified-field', count: 18 },
        { name: 'cosmic', count: 30 },
        { name: 'vortex', count: 22 },
        { name: 'mathematics', count: 15 },
        { name: 'rodin', count: 8 },
        { name: 'golden-ratio', count: 12 },
        { name: 'phi', count: 10 },
        { name: 'beauty', count: 14 },
        { name: 'zeropoint', count: 35 },
      ]

      render json: { tags: tags }
    end

    # Share target handler for PWA
    def share
      # Handle shared content from PWA
      shared_data = {
        title: params[:title],
        text: params[:text],
        url: params[:url],
        timestamp: Time.current,
      }

      # In a real app, you might save this to a database
      Rails.logger.info "Shared content: #{shared_data}"

      render json: { success: true, message: 'Content shared successfully' }
    end

    private

    def load_sample_posts
      [
        {
          id: 1,
          title: '🌌 Zeropoint Consciousness: The Unified Field Theory',
          excerpt: 'Exploring the cosmic equation where consciousness equals interface. From zero, infinity flows through unified intelligence.',
          content: 'Full post content about consciousness and the unified field theory...',
          author: 'Zeropoint Team',
          date: '2024-06-29',
          category: 'consciousness',
          tags: [ 'consciousness', 'unified-field', 'cosmic' ],
          image: '/assets/images/consciousness.jpg',
          readTime: 5,
          slug: 'zeropoint-consciousness-unified-field',
        },
        {
          id: 2,
          title: '🌀 Vortex Mathematics: Marco Rodin\'s Patterns',
          excerpt: 'Understanding the mathematical vortex patterns that govern reality. The universe is a mathematical vortex.',
          content: 'Full post content about vortex mathematics and Marco Rodin\'s patterns...',
          author: 'Zeropoint Team',
          date: '2024-06-28',
          category: 'vortex',
          tags: [ 'vortex', 'mathematics', 'rodin' ],
          image: '/assets/images/vortex.jpg',
          readTime: 7,
          slug: 'vortex-mathematics-rodin-patterns',
        },
        {
          id: 3,
          title: 'φ Golden Ratio: The Mathematical Constant of Beauty',
          excerpt: 'Discovering the golden ratio in nature, art, and consciousness. φ is the mathematical constant of beauty and balance.',
          content: 'Full post content about the golden ratio and its applications...',
          author: 'Zeropoint Team',
          date: '2024-06-27',
          category: 'golden-ratio',
          tags: [ 'golden-ratio', 'phi', 'beauty', 'mathematics' ],
          image: '/assets/images/golden-ratio.jpg',
          readTime: 6,
          slug: 'golden-ratio-mathematical-constant-beauty',
        },
        {
          id: 4,
          title: '🌌 Cosmic Flow: The River of Consciousness',
          excerpt: 'Understanding how consciousness flows through the cosmic field like a river of infinite possibilities.',
          content: 'Full post content about cosmic flow and consciousness...',
          author: 'Zeropoint Team',
          date: '2024-06-26',
          category: 'cosmic',
          tags: [ 'cosmic', 'consciousness', 'flow' ],
          image: '/assets/images/cosmic-flow.jpg',
          readTime: 8,
          slug: 'cosmic-flow-river-consciousness',
        },
        {
          id: 5,
          title: '🧠 Quantum Consciousness: Beyond the Observer',
          excerpt: 'Exploring quantum consciousness and how the observer affects reality through zeropoint logic.',
          content: 'Full post content about quantum consciousness...',
          author: 'Zeropoint Team',
          date: '2024-06-25',
          category: 'consciousness',
          tags: [ 'consciousness', 'quantum', 'observer' ],
          image: '/assets/images/quantum-consciousness.jpg',
          readTime: 9,
          slug: 'quantum-consciousness-beyond-observer',
        },
        {
          id: 6,
          title: '🌀 Vortex Energy: The Spiral of Creation',
          excerpt: 'Understanding vortex energy and how spiral patterns create the foundation of all existence.',
          content: 'Full post content about vortex energy and creation...',
          author: 'Zeropoint Team',
          date: '2024-06-24',
          category: 'vortex',
          tags: [ 'vortex', 'energy', 'spiral', 'creation' ],
          image: '/assets/images/vortex-energy.jpg',
          readTime: 7,
          slug: 'vortex-energy-spiral-creation',
        },
      ]
    end

    def filter_posts(posts, params)
      filtered = posts

      # Filter by search query
      if params[:q].present?
        query = params[:q].downcase
        filtered = filtered.select do |post|
          post[:title].downcase.include?(query) ||
          post[:excerpt].downcase.include?(query) ||
          post[:tags].any? { |tag| tag.downcase.include?(query) }
        end
      end

      # Filter by category
      if params[:category].present?
        filtered = filtered.select { |post| post[:category] == params[:category] }
      end

      # Filter by tags
      if params[:tags].present?
        tags = params[:tags].split(',')
        filtered = filtered.select do |post|
          tags.any? { |tag| post[:tags].include?(tag) }
        end
      end

      # Sort posts
      sort_by = params[:sort_by] || 'date'
      sort_order = params[:sort_order] || 'desc'

      filtered.sort_by! { |post| post[sort_by.to_sym] }
      filtered.reverse! if sort_order == 'desc'

      filtered
    end
  end
end
