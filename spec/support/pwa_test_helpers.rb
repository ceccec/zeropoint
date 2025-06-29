# frozen_string_literal: true

# PWA Test Helpers
# Helper methods for testing Progressive Web Application functionality

module PwaTestHelpers
  # Mock service worker registration
  def mock_service_worker_registration
    allow(navigator).to receive(:serviceWorker).and_return(
      double(
        register: Promise.resolve(double(
          active: double(state: 'activated'),
          installing: nil,
          waiting: nil
        )),
        getRegistrations: Promise.resolve([]),
        ready: Promise.resolve(double)
      )
    )
  end

  # Mock PWA installation prompt
  def mock_install_prompt
    allow(window).to receive(:addEventListener).with('beforeinstallprompt', anything)
    allow(window).to receive(:addEventListener).with('appinstalled', anything)
  end

  # Mock offline/online events
  def mock_network_events
    allow(window).to receive(:addEventListener).with('online', anything)
    allow(window).to receive(:addEventListener).with('offline', anything)
    allow(navigator).to receive(:onLine).and_return(true)
  end

  # Mock PWA manifest
  def mock_pwa_manifest
    {
      name: '🌌 Astro Blog - Zeropoint PWA',
      short_name: 'Astro Blog',
      description: 'Exploring consciousness through zeropoint logic',
      start_url: '/',
      display: 'standalone',
      background_color: '#0f172a',
      theme_color: '#1e293b',
      icons: [
        {
          src: '/assets/icon-192.png',
          sizes: '192x192',
          type: 'image/png',
          purpose: 'maskable any',
        },
      ],
    }
  end

  # Assert PWA meta tags are present
  def expect_pwa_meta_tags(response_body)
    expect(response_body).to include('name="description"')
    expect(response_body).to include('name="theme-color"')
    expect(response_body).to include('name="apple-mobile-web-app-capable"')
    expect(response_body).to include('name="apple-mobile-web-app-status-bar-style"')
    expect(response_body).to include('name="apple-mobile-web-app-title"')
    expect(response_body).to include('rel="manifest"')
  end

  # Assert PWA manifest link is present
  def expect_pwa_manifest_link(response_body)
    expect(response_body).to include('href="/astro-blog-manifest.json"')
  end

  # Assert service worker registration is present
  def expect_service_worker_registration(response_body)
    expect(response_body).to include('/astro-blog-sw.js')
    expect(response_body).to include('navigator.serviceWorker.register')
  end

  # Assert cosmic design elements are present
  def expect_cosmic_design_elements(response_body)
    expect(response_body).to include('pwa-container')
    expect(response_body).to include('cosmic-particles')
    expect(response_body).to include('astro-loader')
    expect(response_body).to include('offline-indicator')
  end

  # Assert Stimulus controllers are present
  def expect_stimulus_controllers(response_body)
    expect(response_body).to include('data-controller="astro-blog pwa-manager"')
    expect(response_body).to include('data-astro-blog-target="posts"')
    expect(response_body).to include('data-astro-blog-target="search"')
    expect(response_body).to include('data-astro-blog-target="pagination"')
    expect(response_body).to include('data-astro-blog-target="content"')
    expect(response_body).to include('data-astro-blog-target="log"')
    expect(response_body).to include('data-pwa-manager-target="installButton"')
    expect(response_body).to include('data-pwa-manager-target="offlineIndicator"')
  end

  # Assert consciousness-themed content
  def expect_consciousness_content(response_body)
    expect(response_body).to include('consciousness')
    expect(response_body).to include('vortex')
    expect(response_body).to include('cosmic')
    expect(response_body).to include('🌌')
    expect(response_body).to include('🌀')
  end

  # Assert PWA installation elements
  def expect_pwa_installation_elements(response_body)
    expect(response_body).to include('📱 Install PWA')
    expect(response_body).to include('id="install-button"')
    expect(response_body).to include('class="hidden"')
  end

  # Assert offline functionality elements
  def expect_offline_elements(response_body)
    expect(response_body).to include('📡 You\'re offline')
    expect(response_body).to include('id="offline-indicator"')
    expect(response_body).to include('class="offline-indicator"')
  end

  # Assert consciousness boost buttons
  def expect_consciousness_boost_buttons(response_body)
    expect(response_body).to include('🧠 Boost Consciousness')
    expect(response_body).to include('🌀 Boost Vortex')
    expect(response_body).to include('φ Boost Golden')
  end

  # Assert activity log elements
  def expect_activity_log_elements(response_body)
    expect(response_body).to include('📊 Activity Log')
    expect(response_body).to include('data-astro-blog-target="log"')
    expect(response_body).to include('🧹 Clear Log')
  end

  # Mock UUID generation for testing
  def mock_uuid_generation
    allow_any_instance_of(Object).to receive(:generate_uuid).and_return('test-uuid-12345')
  end

  # Assert UUID generation in logs
  def expect_uuid_in_logs(logs, action = nil)
    uuid_pattern = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
    expect(logs.any? { |log| log.message.match(uuid_pattern) }).to be(true)

    if action
      expect(logs.any? { |log| log.message.include?(action) }).to be(true)
    end
  end

  # Assert PWA status
  def expect_pwa_status(status)
    expect(status).to have_key('isInstalled')
    expect(status).to have_key('isOnline')
    expect(status).to have_key('hasInstallPrompt')
    expect(status).to have_key('serviceWorkerSupported')
  end

  # Mock PWA installation
  def mock_pwa_installed
    allow(window).to receive(:matchMedia).with('(display-mode: standalone)').and_return(
      double(matches: true)
    )
  end

  # Mock PWA not installed
  def mock_pwa_not_installed
    allow(window).to receive(:matchMedia).with('(display-mode: standalone)').and_return(
      double(matches: false)
    )
  end

  # Assert PWA manifest structure
  def expect_pwa_manifest_structure(manifest)
    expect(manifest['name']).to eq('🌌 Astro Blog - Zeropoint PWA')
    expect(manifest['short_name']).to eq('Astro Blog')
    expect(manifest['display']).to eq('standalone')
    expect(manifest['theme_color']).to eq('#1e293b')
    expect(manifest['background_color']).to eq('#0f172a')
    expect(manifest['icons']).to be_an(Array)
    expect(manifest['shortcuts']).to be_an(Array)
    expect(manifest['share_target']).to be_present
  end

  # Assert service worker functionality
  def expect_service_worker_functionality(sw_content)
    expect(sw_content).to include('Astro Blog PWA Service Worker')
    expect(sw_content).to include('self.addEventListener(\'install\'')
    expect(sw_content).to include('self.addEventListener(\'activate\'')
    expect(sw_content).to include('self.addEventListener(\'fetch\'')
    expect(sw_content).to include('self.addEventListener(\'sync\'')
    expect(sw_content).to include('self.addEventListener(\'push\'')
  end

  # Assert offline page content
  def expect_offline_page_content(content)
    expect(content).to include('🌌 Offline in Space')
    expect(content).to include('You\'ve ventured beyond the cosmic network')
    expect(content).to include('🔄 Retry Connection')
    expect(content).to include('← Go Back')
    expect(content).to include('🏠 Return Home')
  end

  # Mock cosmic particles generation
  def mock_cosmic_particles
    allow_any_instance_of(Object).to receive(:generateParticles).and_return(true)
  end

  # Assert cosmic particles in DOM
  def expect_cosmic_particles_in_dom(page)
    expect(page).to have_css('#cosmic-particles')
    particles = page.all('#cosmic-particles .particle')
    expect(particles.length).to be >= 30
  end

  # Mock consciousness boost interactions
  def mock_consciousness_boost
    allow_any_instance_of(Object).to receive(:boostConsciousness).and_return(true)
    allow_any_instance_of(Object).to receive(:boostVortex).and_return(true)
    allow_any_instance_of(Object).to receive(:boostGolden).and_return(true)
  end

  # Assert consciousness boost buttons are present
  def expect_consciousness_boost_buttons_present(page)
    expect(page).to have_button('🧠 Boost Consciousness')
    expect(page).to have_button('🌀 Boost Vortex')
    expect(page).to have_button('φ Boost Golden')
  end

  # Mock API responses for blog posts
  def mock_blog_posts_response
    {
      posts: [
        {
          id: 1,
          title: '🌌 Test Consciousness Post',
          excerpt: 'Test excerpt about consciousness',
          content: 'Full test content',
          author: 'Test Author',
          date: '2024-06-29',
          category: 'consciousness',
          tags: [ 'consciousness', 'test' ],
          image: '/test-image.jpg',
          readTime: 5,
          slug: 'test-post',
        },
      ],
      pagination: {
        current_page: 1,
        total_pages: 1,
        total_posts: 1,
        per_page: 6,
      },
    }
  end

  # Assert blog post structure
  def expect_blog_post_structure(post)
    expect(post).to have_key('id')
    expect(post).to have_key('title')
    expect(post).to have_key('excerpt')
    expect(post).to have_key('content')
    expect(post).to have_key('author')
    expect(post).to have_key('date')
    expect(post).to have_key('category')
    expect(post).to have_key('tags')
    expect(post).to have_key('image')
    expect(post).to have_key('readTime')
    expect(post).to have_key('slug')
  end

  # Assert pagination structure
  def expect_pagination_structure(pagination)
    expect(pagination).to have_key('current_page')
    expect(pagination).to have_key('total_pages')
    expect(pagination).to have_key('total_posts')
    expect(pagination).to have_key('per_page')
  end

  # Mock search functionality
  def mock_search_functionality
    allow_any_instance_of(Object).to receive(:search).and_return(mock_blog_posts_response)
  end

  # Mock filtering functionality
  def mock_filter_functionality
    allow_any_instance_of(Object).to receive(:filterByCategory).and_return(mock_blog_posts_response)
    allow_any_instance_of(Object).to receive(:filterByTags).and_return(mock_blog_posts_response)
  end

  # Mock pagination functionality
  def mock_pagination_functionality
    allow_any_instance_of(Object).to receive(:goToPage).and_return(mock_blog_posts_response)
  end

  # Assert responsive design elements
  def expect_responsive_design_elements(response_body)
    expect(response_body).to include('grid-cols-1')
    expect(response_body).to include('lg:grid-cols-4')
    expect(response_body).to include('md:grid-cols-2')
  end

  # Assert accessibility elements
  def expect_accessibility_elements(response_body)
    expect(response_body).to include('<h1')
    expect(response_body).to include('<h3')
    expect(response_body).to include('placeholder=')
    expect(response_body).to include('aria-')
  end

  # Mock performance timing
  def mock_performance_timing
    allow(Time).to receive(:current).and_return(Time.zone.local(2024, 6, 29, 12, 0, 0))
  end

  # Assert performance requirements
  def expect_performance_requirements(start_time, end_time, max_duration_ms = 200)
    response_time = (end_time - start_time) * 1000 # Convert to milliseconds
    expect(response_time).to be < max_duration_ms
  end

  # Mock security headers
  def mock_security_headers
    {
      "X-Content-Type-Options": 'nosniff',
      "X-Frame-Options": 'SAMEORIGIN',
      "X-XSS-Protection": '1; mode=block',
    }
  end

  # Assert security headers
  def expect_security_headers(response)
    expect(response.headers['X-Content-Type-Options']).to eq('nosniff')
    expect(response.headers['X-Frame-Options']).to eq('SAMEORIGIN')
    expect(response.headers['X-XSS-Protection']).to eq('1; mode=block')
  end

  # Mock CORS headers
  def mock_cors_headers
    {
      "Access-Control-Allow-Origin": '*',
      "Access-Control-Allow-Methods": 'GET, POST, OPTIONS',
      "Access-Control-Allow-Headers": 'Content-Type',
    }
  end

  # Assert CORS headers
  def expect_cors_headers(response)
    expect(response.headers['Access-Control-Allow-Origin']).to be_present
    expect(response.headers['Access-Control-Allow-Methods']).to be_present
    expect(response.headers['Access-Control-Allow-Headers']).to be_present
  end
end

# Include helpers in RSpec
RSpec.configure do |config|
  config.include PwaTestHelpers, type: :request
  config.include PwaTestHelpers, type: :system
  config.include PwaTestHelpers, type: :controller
end
