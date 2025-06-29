// Astro Blog Controller Tests
// Tests for the main blog functionality and PWA integration

import { Application } from '@hotwired/stimulus'
import AstroBlogController from '../../app/assets/javascripts/zeropoint/controllers/astro-blog-controller.js'
import { UuidMatrix } from '../../app/assets/javascripts/zeropoint/utils/uuid-matrix.js'

// Mock fetch for API calls
global.fetch = jest.fn()

// Mock console for testing
global.console = {
  log: jest.fn(),
  error: jest.fn(),
  warn: jest.fn()
}

describe('AstroBlogController', () => {
  let application
  let controller
  let element

  beforeEach(() => {
    // Setup DOM element
    element = document.createElement('div')
    element.innerHTML = `
      <input data-astro-blog-target="search" type="text" placeholder="Search posts...">
      <div data-astro-blog-target="posts"></div>
      <div data-astro-blog-target="pagination"></div>
      <div data-astro-blog-target="content"></div>
      <div data-astro-blog-target="log"></div>
      <div data-astro-blog-target="sidebar"></div>
    `

    // Setup Stimulus application
    application = Application.start()
    application.register('astro-blog', AstroBlogController)
    
    // Add controller to element
    element.setAttribute('data-controller', 'astro-blog')
    
    // Mock API responses
    fetch.mockResolvedValue({
      ok: true,
      json: () => Promise.resolve({
        posts: [
          {
            id: 1,
            title: '🌌 Test Post',
            excerpt: 'Test excerpt',
            content: 'Test content',
            author: 'Test Author',
            date: '2024-06-29',
            category: 'consciousness',
            tags: ['consciousness', 'test'],
            image: '/test.jpg',
            readTime: 5,
            slug: 'test-post'
          }
        ],
        pagination: {
          current_page: 1,
          total_pages: 1,
          total_posts: 1,
          per_page: 6
        }
      })
    })
  })

  afterEach(() => {
    application.stop()
    fetch.mockClear()
    console.log.mockClear()
    console.error.mockClear()
  })

  describe('Initialization', () => {
    it('connects successfully', () => {
      document.body.appendChild(element)
      
      expect(console.log).to haveBeenCalledWith('🌌 Astro Blog Controller connected')
    })

    it('generates UUID on connect', () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      document.body.appendChild(element)
      
      expect(uuidSpy).to haveBeenCalledWith({
        action: 'connect',
        component: 'astro-blog',
        state: 'active',
        vortex: 'flowing'
      })
    })

    it('loads initial posts', () => {
      document.body.appendChild(element)
      
      expect(fetch).to haveBeenCalledWith('/zeropoint/astro-blog/posts?page=1&per_page=6')
    })
  })

  describe('Search Functionality', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('debounces search input', async () => {
      const searchInput = element.querySelector('[data-astro-blog-target="search"]')
      
      // Type in search
      searchInput.value = 'consciousness'
      searchInput.dispatchEvent(new Event('input'))
      
      // Should not immediately search
      expect(fetch).toHaveBeenCalledTimes(1) // Only initial load
      
      // Wait for debounce
      await new Promise(resolve => setTimeout(resolve, 400))
      
      // Should search after debounce
      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining('/zeropoint/astro-blog/posts'),
        expect.objectContaining({
          method: 'GET'
        })
      )
    })

    it('generates UUID for search actions', async () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      const searchInput = element.querySelector('[data-astro-blog-target="search"]')
      
      searchInput.value = 'test'
      searchInput.dispatchEvent(new Event('input'))
      
      await new Promise(resolve => setTimeout(resolve, 400))
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'search',
        component: 'astro-blog',
        state: 'active',
        vortex: 'flowing'
      })
    })
  })

  describe('Post Rendering', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('renders posts in grid', async () => {
      await controller.loadPosts()
      
      const postsContainer = element.querySelector('[data-astro-blog-target="posts"]')
      expect(postsContainer.innerHTML).toContain('🌌 Test Post')
      expect(postsContainer.innerHTML).toContain('Test excerpt')
    })

    it('renders pagination', async () => {
      await controller.loadPosts()
      
      const paginationContainer = element.querySelector('[data-astro-blog-target="pagination"]')
      expect(paginationContainer.innerHTML).toContain('1')
      expect(paginationContainer.innerHTML).toContain('1')
    })

    it('handles empty posts gracefully', async () => {
      fetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve({
          posts: [],
          pagination: {
            current_page: 1,
            total_pages: 0,
            total_posts: 0,
            per_page: 6
          }
        })
      })
      
      await controller.loadPosts()
      
      const postsContainer = element.querySelector('[data-astro-blog-target="posts"]')
      expect(postsContainer.innerHTML).toContain('No posts found')
    })
  })

  describe('Consciousness Boost Interactions', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('handles consciousness boost', () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      controller.boostConsciousness()
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'boost-consciousness',
        component: 'astro-blog',
        state: 'active',
        vortex: 'flowing'
      })
      
      expect(console.log).toHaveBeenCalledWith(
        expect.stringContaining('[Astro Blog] Action: boost-consciousness')
      )
    })

    it('handles vortex boost', () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      controller.boostVortex()
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'boost-vortex',
        component: 'astro-blog',
        state: 'active',
        vortex: 'flowing'
      })
    })

    it('handles golden ratio boost', () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      controller.boostGolden()
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'boost-golden',
        component: 'astro-blog',
        state: 'active',
        vortex: 'flowing'
      })
    })
  })

  describe('Activity Logging', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('logs actions to activity log', () => {
      controller.logAction('test-action')
      
      const logContainer = element.querySelector('[data-astro-blog-target="log"]')
      expect(logContainer.innerHTML).toContain('test-action')
    })

    it('clears activity log', () => {
      // Add some log entries
      controller.logAction('test-action-1')
      controller.logAction('test-action-2')
      
      const logContainer = element.querySelector('[data-astro-blog-target="log"]')
      expect(logContainer.children.length).toBeGreaterThan(0)
      
      // Clear log
      controller.clearLog()
      
      expect(logContainer.children.length).toBe(0)
    })

    it('limits log entries', () => {
      // Add many log entries
      for (let i = 0; i < 20; i++) {
        controller.logAction(`test-action-${i}`)
      }
      
      const logContainer = element.querySelector('[data-astro-blog-target="log"]')
      expect(logContainer.children.length).toBeLessThanOrEqual(10)
    })
  })

  describe('Error Handling', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('handles API errors gracefully', async () => {
      fetch.mockRejectedValueOnce(new Error('API Error'))
      
      await controller.loadPosts()
      
      expect(console.error).toHaveBeenCalledWith(
        expect.stringContaining('Failed to load posts')
      )
    })

    it('handles network errors', async () => {
      fetch.mockRejectedValueOnce(new TypeError('Network error'))
      
      await controller.loadPosts()
      
      expect(console.error).toHaveBeenCalledWith(
        expect.stringContaining('Network error')
      )
    })
  })

  describe('Pagination', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('handles page navigation', async () => {
      await controller.goToPage(2)
      
      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining('page=2')
      )
    })

    it('generates UUID for pagination', async () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      await controller.goToPage(2)
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'paginate',
        component: 'astro-blog',
        state: 'active',
        vortex: 'flowing'
      })
    })
  })

  describe('Category and Tag Filtering', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('filters by category', async () => {
      await controller.filterByCategory('consciousness')
      
      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining('category=consciousness')
      )
    })

    it('filters by tags', async () => {
      await controller.filterByTags(['consciousness', 'cosmic'])
      
      expect(fetch).toHaveBeenCalledWith(
        expect.stringContaining('tags=consciousness,cosmic')
      )
    })

    it('generates UUID for filtering', async () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      await controller.filterByCategory('consciousness')
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'filter',
        component: 'astro-blog',
        state: 'active',
        vortex: 'flowing'
      })
    })
  })

  describe('Post Viewing', () => {
    beforeEach(() => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
    })

    it('loads full post content', async () => {
      fetch.mockResolvedValueOnce({
        ok: true,
        json: () => Promise.resolve({
          id: 1,
          title: '🌌 Full Post',
          content: 'Full post content here...',
          author: 'Author',
          date: '2024-06-29'
        })
      })
      
      await controller.viewPost(1)
      
      const contentContainer = element.querySelector('[data-astro-blog-target="content"]')
      expect(contentContainer.innerHTML).toContain('🌌 Full Post')
      expect(contentContainer.innerHTML).toContain('Full post content here...')
    })

    it('generates UUID for post viewing', async () => {
      const uuidSpy = jest.spyOn(UuidMatrix, 'generate')
      
      await controller.viewPost(1)
      
      expect(uuidSpy).toHaveBeenCalledWith({
        action: 'view',
        component: 'astro-blog',
        state: 'active',
        vortex: 'flowing'
      })
    })
  })

  describe('Disconnection', () => {
    it('cleans up event listeners', () => {
      document.body.appendChild(element)
      controller = application.getControllerForElementAndIdentifier(element, 'astro-blog')
      
      const disconnectSpy = jest.spyOn(controller, 'disconnect')
      
      element.remove()
      
      expect(disconnectSpy).toHaveBeenCalled()
    })
  })
}) 