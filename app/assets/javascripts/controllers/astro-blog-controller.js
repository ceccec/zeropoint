// COMPONENT BEST PRACTICE: Stimulus controller for Astro blog integration with TypeScript support.
import { Controller } from '@hotwired/stimulus'
import { UuidMatrix } from '../utils/uuid-matrix.js'

export default class AstroBlogController extends Controller {
  static targets = ['posts', 'navigation', 'search', 'pagination', 'sidebar', 'content']
  static values = {
    posts: { type: Array, default: [] },
    currentPage: { type: Number, default: 1 },
    postsPerPage: { type: Number, default: 6 },
    searchQuery: { type: String, default: '' },
    category: { type: String, default: '' },
    tags: { type: Array, default: [] },
    sortBy: { type: String, default: 'date' },
    sortOrder: { type: String, default: 'desc' }
  }

  connect() {
    console.log('Astro Blog Controller connected')
    this.initializeBlog()
    this.setupEventListeners()
    this.loadPosts()
    this.logAction('connect')
  }

  disconnect() {
    this.cleanupEventListeners()
  }

  // Initialize blog functionality
  initializeBlog() {
    this.currentPosts = []
    this.filteredPosts = []
    this.setupIntersectionObserver()
    this.initializeSearch()
  }

  // Setup event listeners for blog interactions
  setupEventListeners() {
    // Search functionality
    if (this.hasSearchTarget) {
      this.searchTarget.addEventListener('input', this.debounce(this.handleSearch.bind(this), 300))
    }

    // Navigation events
    this.element.addEventListener('astro:post-click', this.handlePostClick.bind(this))
    this.element.addEventListener('astro:category-change', this.handleCategoryChange.bind(this))
    this.element.addEventListener('astro:tag-filter', this.handleTagFilter.bind(this))
  }

  // Cleanup event listeners
  cleanupEventListeners() {
    if (this.hasSearchTarget) {
      this.searchTarget.removeEventListener('input', this.handleSearch.bind(this))
    }
    this.element.removeEventListener('astro:post-click', this.handlePostClick.bind(this))
    this.element.removeEventListener('astro:category-change', this.handleCategoryChange.bind(this))
    this.element.removeEventListener('astro:tag-filter', this.handleTagFilter.bind(this))
  }

  // Load blog posts from API or static data
  async loadPosts() {
    try {
      // In a real implementation, this would fetch from your Rails API
      const response = await fetch('/api/blog/posts')
      const posts = await response.json()
      this.postsValue = posts
      this.renderPosts()
    } catch (error) {
      console.error('Failed to load posts:', error)
      this.loadSamplePosts()
    }
  }

  // Load sample posts for development
  loadSamplePosts() {
    const samplePosts = [
      {
        id: 1,
        title: '🌌 Zeropoint Consciousness: The Unified Field Theory',
        excerpt: 'Exploring the cosmic equation where consciousness equals interface...',
        content: 'Full post content here...',
        author: 'Zeropoint Team',
        date: '2024-06-29',
        category: 'consciousness',
        tags: ['consciousness', 'unified-field', 'cosmic'],
        image: '/assets/images/consciousness.jpg',
        readTime: 5,
        slug: 'zeropoint-consciousness-unified-field'
      },
      {
        id: 2,
        title: '🌀 Vortex Mathematics: Marco Rodin\'s Patterns',
        excerpt: 'Understanding the mathematical vortex patterns that govern reality...',
        content: 'Full post content here...',
        author: 'Zeropoint Team',
        date: '2024-06-28',
        category: 'vortex',
        tags: ['vortex', 'mathematics', 'rodin'],
        image: '/assets/images/vortex.jpg',
        readTime: 7,
        slug: 'vortex-mathematics-rodin-patterns'
      },
      {
        id: 3,
        title: 'φ Golden Ratio: The Mathematical Constant of Beauty',
        excerpt: 'Discovering the golden ratio in nature, art, and consciousness...',
        content: 'Full post content here...',
        author: 'Zeropoint Team',
        date: '2024-06-27',
        category: 'golden-ratio',
        tags: ['golden-ratio', 'phi', 'beauty', 'mathematics'],
        image: '/assets/images/golden-ratio.jpg',
        readTime: 6,
        slug: 'golden-ratio-mathematical-constant-beauty'
      }
    ]
    this.postsValue = samplePosts
    this.renderPosts()
  }

  // Render posts to the DOM
  renderPosts() {
    if (!this.hasPostsTarget) return

    const filteredPosts = this.getFilteredPosts()
    const paginatedPosts = this.getPaginatedPosts(filteredPosts)
    
    this.postsTarget.innerHTML = paginatedPosts.map(post => this.renderPostCard(post)).join('')
    this.updatePagination(filteredPosts.length)
    this.updateSidebar()
  }

  // Render individual post card
  renderPostCard(post) {
    return `
      <article class="astro-post-card zeropoint-card mb-6 transition-all duration-300 hover:transform hover:scale-105"
               data-post-id="${post.id}"
               data-action="click->astro-blog#selectPost">
        <div class="relative overflow-hidden rounded-lg">
          <img src="${post.image}" alt="${post.title}" 
               class="w-full h-48 object-cover transition-transform duration-300 hover:scale-110">
          <div class="absolute top-4 left-4">
            <span class="px-3 py-1 bg-${this.getCategoryColor(post.category)}-600 text-white text-sm rounded-full">
              ${post.category}
            </span>
          </div>
        </div>
        
        <div class="p-6">
          <div class="flex items-center text-sm text-cosmic-500 mb-3">
            <span>${post.author}</span>
            <span class="mx-2">•</span>
            <span>${this.formatDate(post.date)}</span>
            <span class="mx-2">•</span>
            <span>${post.readTime} min read</span>
          </div>
          
          <h3 class="text-xl font-bold text-cosmic-900 mb-3 hover:text-consciousness-600 transition-colors">
            ${post.title}
          </h3>
          
          <p class="text-cosmic-600 mb-4 line-clamp-3">
            ${post.excerpt}
          </p>
          
          <div class="flex items-center justify-between">
            <div class="flex flex-wrap gap-2">
              ${post.tags.map(tag => `
                <span class="px-2 py-1 bg-cosmic-100 text-cosmic-600 text-xs rounded-full hover:bg-cosmic-200 transition-colors"
                      data-action="click->astro-blog#filterByTag"
                      data-tag="${tag}">
                  #${tag}
                </span>
              `).join('')}
            </div>
            
            <button class="zeropoint-button-primary text-sm"
                    data-action="click->astro-blog#readPost"
                    data-post-id="${post.id}">
              Read More
            </button>
          </div>
        </div>
      </article>
    `
  }

  // Get filtered posts based on search and category
  getFilteredPosts() {
    let filtered = this.postsValue

    // Filter by search query
    if (this.searchQueryValue) {
      const query = this.searchQueryValue.toLowerCase()
      filtered = filtered.filter(post => 
        post.title.toLowerCase().includes(query) ||
        post.excerpt.toLowerCase().includes(query) ||
        post.content.toLowerCase().includes(query) ||
        post.tags.some(tag => tag.toLowerCase().includes(query))
      )
    }

    // Filter by category
    if (this.categoryValue) {
      filtered = filtered.filter(post => post.category === this.categoryValue)
    }

    // Filter by tags
    if (this.tagsValue.length > 0) {
      filtered = filtered.filter(post => 
        this.tagsValue.some(tag => post.tags.includes(tag))
      )
    }

    // Sort posts
    filtered.sort((a, b) => {
      const aValue = a[this.sortByValue]
      const bValue = b[this.sortByValue]
      
      if (this.sortOrderValue === 'asc') {
        return aValue > bValue ? 1 : -1
      } else {
        return aValue < bValue ? 1 : -1
      }
    })

    return filtered
  }

  // Get paginated posts
  getPaginatedPosts(posts) {
    const start = (this.currentPageValue - 1) * this.postsPerPageValue
    const end = start + this.postsPerPageValue
    return posts.slice(start, end)
  }

  // Update pagination controls
  updatePagination(totalPosts) {
    if (!this.hasPaginationTarget) return

    const totalPages = Math.ceil(totalPosts / this.postsPerPageValue)
    const currentPage = this.currentPageValue

    this.paginationTarget.innerHTML = `
      <div class="flex items-center justify-center space-x-2">
        <button class="zeropoint-button-secondary ${currentPage === 1 ? 'opacity-50 cursor-not-allowed' : ''}"
                data-action="click->astro-blog#previousPage"
                ${currentPage === 1 ? 'disabled' : ''}>
          Previous
        </button>
        
        <div class="flex space-x-1">
          ${this.generatePageNumbers(currentPage, totalPages)}
        </div>
        
        <button class="zeropoint-button-secondary ${currentPage === totalPages ? 'opacity-50 cursor-not-allowed' : ''}"
                data-action="click->astro-blog#nextPage"
                ${currentPage === totalPages ? 'disabled' : ''}>
          Next
        </button>
      </div>
    `
  }

  // Generate page number buttons
  generatePageNumbers(currentPage, totalPages) {
    const pages = []
    const maxVisible = 5
    
    let start = Math.max(1, currentPage - Math.floor(maxVisible / 2))
    let end = Math.min(totalPages, start + maxVisible - 1)
    
    if (end - start + 1 < maxVisible) {
      start = Math.max(1, end - maxVisible + 1)
    }
    
    for (let i = start; i <= end; i++) {
      pages.push(`
        <button class="w-10 h-10 rounded-md ${i === currentPage ? 'bg-consciousness-600 text-white' : 'bg-cosmic-100 text-cosmic-600 hover:bg-cosmic-200'}"
                data-action="click->astro-blog#goToPage"
                data-page="${i}">
          ${i}
        </button>
      `)
    }
    
    return pages.join('')
  }

  // Update sidebar with categories and tags
  updateSidebar() {
    if (!this.hasSidebarTarget) return

    const categories = this.getCategories()
    const tags = this.getTags()

    this.sidebarTarget.innerHTML = `
      <div class="space-y-6">
        <!-- Categories -->
        <div>
          <h3 class="text-lg font-bold text-cosmic-900 mb-3">Categories</h3>
          <div class="space-y-2">
            ${categories.map(category => `
              <button class="w-full text-left px-3 py-2 rounded-md hover:bg-cosmic-100 transition-colors ${this.categoryValue === category.name ? 'bg-consciousness-100 text-consciousness-700' : 'text-cosmic-600'}"
                      data-action="click->astro-blog#selectCategory"
                      data-category="${category.name}">
                <span class="flex items-center justify-between">
                  <span>${category.name}</span>
                  <span class="text-sm bg-cosmic-200 text-cosmic-600 px-2 py-1 rounded-full">${category.count}</span>
                </span>
              </button>
            `).join('')}
          </div>
        </div>
        
        <!-- Tags -->
        <div>
          <h3 class="text-lg font-bold text-cosmic-900 mb-3">Tags</h3>
          <div class="flex flex-wrap gap-2">
            ${tags.map(tag => `
              <button class="px-3 py-1 bg-cosmic-100 text-cosmic-600 text-sm rounded-full hover:bg-cosmic-200 transition-colors ${this.tagsValue.includes(tag.name) ? 'bg-consciousness-100 text-consciousness-700' : ''}"
                      data-action="click->astro-blog#toggleTag"
                      data-tag="${tag.name}">
                #${tag.name} (${tag.count})
              </button>
            `).join('')}
          </div>
        </div>
      </div>
    `
  }

  // Get unique categories with counts
  getCategories() {
    const categories = {}
    this.postsValue.forEach(post => {
      categories[post.category] = (categories[post.category] || 0) + 1
    })
    return Object.entries(categories).map(([name, count]) => ({ name, count }))
  }

  // Get unique tags with counts
  getTags() {
    const tags = {}
    this.postsValue.forEach(post => {
      post.tags.forEach(tag => {
        tags[tag] = (tags[tag] || 0) + 1
      })
    })
    return Object.entries(tags).map(([name, count]) => ({ name, count }))
  }

  // Event handlers
  handleSearch(event) {
    this.searchQueryValue = event.target.value
    this.currentPageValue = 1
    this.renderPosts()
    this.logAction('search', { query: this.searchQueryValue })
  }

  handlePostClick(event) {
    const postId = event.detail.postId
    this.selectPost({ currentTarget: { dataset: { postId } } })
  }

  handleCategoryChange(event) {
    this.categoryValue = event.detail.category
    this.currentPageValue = 1
    this.renderPosts()
  }

  handleTagFilter(event) {
    this.tagsValue = event.detail.tags
    this.currentPageValue = 1
    this.renderPosts()
  }

  // Action methods
  selectPost(event) {
    const postId = parseInt(event.currentTarget.dataset.postId)
    const post = this.postsValue.find(p => p.id === postId)
    
    if (post) {
      this.dispatch('post-selected', { detail: { post } })
      this.showPostContent(post)
      this.logAction('view', { postId, post })
    }
  }

  readPost(event) {
    const postId = parseInt(event.currentTarget.dataset.postId)
    const post = this.postsValue.find(p => p.id === postId)
    
    if (post) {
      this.logAction('read', { postId, post })
      window.location.href = `/blog/${post.slug}`
    }
  }

  selectCategory(event) {
    const category = event.currentTarget.dataset.category
    this.categoryValue = this.categoryValue === category ? '' : category
    this.currentPageValue = 1
    this.renderPosts()
    this.logAction('filter', { category: this.categoryValue })
  }

  toggleTag(event) {
    const tag = event.currentTarget.dataset.tag
    const currentTags = [...this.tagsValue]
    
    if (currentTags.includes(tag)) {
      this.tagsValue = currentTags.filter(t => t !== tag)
    } else {
      this.tagsValue = [...currentTags, tag]
    }
    
    this.currentPageValue = 1
    this.renderPosts()
    this.logAction('filter', { tags: this.tagsValue })
  }

  filterByTag(event) {
    const tag = event.currentTarget.dataset.tag
    this.tagsValue = [tag]
    this.currentPageValue = 1
    this.renderPosts()
    this.logAction('filter', { tag })
  }

  previousPage() {
    if (this.currentPageValue > 1) {
      this.currentPageValue--
      this.renderPosts()
      this.logAction('paginate', { page: this.currentPageValue })
    }
  }

  nextPage() {
    const totalPosts = this.getFilteredPosts().length
    const totalPages = Math.ceil(totalPosts / this.postsPerPageValue)
    
    if (this.currentPageValue < totalPages) {
      this.currentPageValue++
      this.renderPosts()
      this.logAction('paginate', { page: this.currentPageValue })
    }
  }

  goToPage(event) {
    const page = parseInt(event.currentTarget.dataset.page)
    this.currentPageValue = page
    this.renderPosts()
    this.logAction('paginate', { page })
  }

  // Show full post content
  showPostContent(post) {
    if (!this.hasContentTarget) return

    this.contentTarget.innerHTML = `
      <article class="astro-post-content">
        <header class="mb-8">
          <div class="flex items-center text-sm text-cosmic-500 mb-4">
            <span>${post.author}</span>
            <span class="mx-2">•</span>
            <span>${this.formatDate(post.date)}</span>
            <span class="mx-2">•</span>
            <span>${post.readTime} min read</span>
          </div>
          
          <h1 class="text-4xl font-bold text-cosmic-900 mb-4">${post.title}</h1>
          
          <div class="flex items-center space-x-4">
            <span class="px-3 py-1 bg-${this.getCategoryColor(post.category)}-600 text-white text-sm rounded-full">
              ${post.category}
            </span>
            <div class="flex space-x-2">
              ${post.tags.map(tag => `
                <span class="px-2 py-1 bg-cosmic-100 text-cosmic-600 text-xs rounded-full">
                  #${tag}
                </span>
              `).join('')}
            </div>
          </div>
        </header>
        
        <div class="prose prose-lg max-w-none">
          ${post.content}
        </div>
      </article>
    `
  }

  // Utility methods
  formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    })
  }

  getCategoryColor(category) {
    const colors = {
      'consciousness': 'consciousness',
      'vortex': 'vortex',
      'golden-ratio': 'golden',
      'cosmic': 'cosmic'
    }
    return colors[category] || 'cosmic'
  }

  debounce(func, wait) {
    let timeout
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout)
        func(...args)
      }
      clearTimeout(timeout)
      timeout = setTimeout(later, wait)
    }
  }

  setupIntersectionObserver() {
    const options = {
      root: null,
      rootMargin: '0px',
      threshold: 0.1
    }

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('animate-fade-in')
        }
      })
    }, options)

    // Observe post cards
    this.element.querySelectorAll('.astro-post-card').forEach(card => {
      observer.observe(card)
    })
  }

  initializeSearch() {
    if (this.hasSearchTarget) {
      this.searchTarget.placeholder = 'Search posts...'
      this.searchTarget.classList.add('w-full', 'px-4', 'py-2', 'border', 'border-cosmic-300', 'rounded-md', 'focus:ring-2', 'focus:ring-consciousness-500', 'focus:border-transparent')
    }
  }

  logAction(action, details = {}) {
    const uuid = UuidMatrix.generate({
      action,
      component: details.component || 'post',
      state: 'active',
      vortex: 'flowing'
    })
    // For now, just log to console. Replace with analytics endpoint as needed.
    console.log(`[AstroBlog] Action: ${action}, UUID: ${uuid}`, details)
  }
} 