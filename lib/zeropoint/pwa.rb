# frozen_string_literal: true

module Zeropoint
  # PWA (Progressive Web Application) Module
  # Central hub for all PWA functionality in the Zeropoint ecosystem
  module PWA
    extend ActiveSupport::Concern

    included do
      # PWA configuration
      class_attribute :pwa_config, default: {
        name: '🌌 Astro Blog - Zeropoint PWA',
        short_name: 'Astro Blog',
        description: 'Exploring consciousness through zeropoint logic',
        start_url: '/',
        display: 'standalone',
        background_color: '#0f172a',
        theme_color: '#1e293b',
        scope: '/',
        orientation: 'portrait-primary',
        categories: [ 'consciousness', 'vortex', 'cosmic' ],
        lang: 'en',
        dir: 'ltr',
      }

      # PWA routes configuration
      class_attribute :pwa_routes, default: {
        root: '/',
        astro_blog: '/zeropoint/astro-blog',
        posts_api: '/zeropoint/astro-blog/posts',
        categories_api: '/zeropoint/astro-blog/categories',
        tags_api: '/zeropoint/astro-blog/tags',
        share_api: '/zeropoint/astro-blog/share',
        manifest: '/astro-blog-manifest.json',
        service_worker: '/astro-blog-sw.js',
        offline_page: '/offline.html',
      }

      # PWA Stimulus controllers configuration
      class_attribute :stimulus_controllers, default: {
        "astro-blog": {
          targets: %w[posts search pagination content log sidebar],
          actions: %w[boostConsciousness boostVortex boostGolden clearLog loadPosts search filterByCategory filterByTags goToPage viewPost],
          values: %w[currentPage perPage searchQuery],
          classes: %w[loading error success],
        },
        "pwa-manager": {
          targets: %w[installButton offlineIndicator],
          actions: %w[install refreshCache checkStatus],
          values: %w[isOnline hasInstallPrompt],
          classes: %w[hidden show],
        },
      }

      # PWA backend endpoints configuration
      class_attribute :backend_endpoints, default: {
        posts: {
          method: 'GET',
          path: '/zeropoint/astro-blog/posts',
          params: %w[page per_page q category tags sort_by sort_order],
          response_keys: %w[posts pagination],
          stimulus_action: 'loadPosts',
        },
        categories: {
          method: 'GET',
          path: '/zeropoint/astro-blog/categories',
          params: [],
          response_keys: %w[categories],
          stimulus_action: 'loadCategories',
        },
        tags: {
          method: 'GET',
          path: '/zeropoint/astro-blog/tags',
          params: [],
          response_keys: %w[tags],
          stimulus_action: 'loadTags',
        },
        share: {
          method: 'POST',
          path: '/zeropoint/astro-blog/share',
          params: %w[title text url],
          response_keys: %w[success message],
          stimulus_action: 'shareContent',
        },
      }
    end

    class_methods do
      # Configure PWA settings
      def configure_pwa(&block)
        yield pwa_config if block
      end

      # Add PWA routes to Rails application
      def add_pwa_routes
        Rails.application.routes.draw do
          # Root redirect to PWA
          root to: redirect(pwa_routes[:astro_blog])

          # PWA main routes
          namespace :zeropoint do
            get 'astro-blog', to: 'astro_blog#index'
            get 'astro-blog/posts', to: 'astro_blog#posts'
            get 'astro-blog/categories', to: 'astro_blog#categories'
            get 'astro-blog/tags', to: 'astro_blog#tags'
            post 'astro-blog/share', to: 'astro_blog#share'
          end

          # PWA static files
          get pwa_routes[:manifest], to: 'pwa#manifest'
          get pwa_routes[:service_worker], to: 'pwa#service_worker'
          get pwa_routes[:offline_page], to: 'pwa#offline'
        end
      end

      # Generate PWA manifest
      def generate_manifest
        {
          name: pwa_config[:name],
          short_name: pwa_config[:short_name],
          description: pwa_config[:description],
          start_url: pwa_config[:start_url],
          display: pwa_config[:display],
          background_color: pwa_config[:background_color],
          theme_color: pwa_config[:theme_color],
          scope: pwa_config[:scope],
          orientation: pwa_config[:orientation],
          categories: pwa_config[:categories],
          lang: pwa_config[:lang],
          dir: pwa_config[:dir],
          icons: generate_icons,
          shortcuts: generate_shortcuts,
          share_target: generate_share_target,
          screenshots: generate_screenshots,
        }
      end

      # Generate PWA icons
      def generate_icons
        [
          {
            src: '/assets/icon-192.png',
            sizes: '192x192',
            type: 'image/png',
            purpose: 'maskable any',
          },
          {
            src: '/assets/icon-512.png',
            sizes: '512x512',
            type: 'image/png',
            purpose: 'maskable any',
          },
          {
            src: '/assets/icon-192.png',
            sizes: '192x192',
            type: 'image/png',
            purpose: 'any',
          },
          {
            src: '/assets/icon-512.png',
            sizes: '512x512',
            type: 'image/png',
            purpose: 'any',
          },
        ]
      end

      # Generate PWA shortcuts
      def generate_shortcuts
        [
          {
            name: 'Latest Posts',
            url: "#{pwa_routes[:astro_blog]}?filter=latest",
            description: 'View latest consciousness posts',
          },
          {
            name: 'Consciousness',
            url: "#{pwa_routes[:astro_blog]}?category=consciousness",
            description: 'Explore consciousness content',
          },
          {
            name: 'Vortex',
            url: "#{pwa_routes[:astro_blog]}?category=vortex",
            description: 'Discover vortex mathematics',
          },
          {
            name: 'Golden Ratio',
            url: "#{pwa_routes[:astro_blog]}?category=golden-ratio",
            description: 'Experience golden ratio harmony',
          },
        ]
      end

      # Generate share target configuration
      def generate_share_target
        {
          action: pwa_routes[:share_api],
          method: 'POST',
          enctype: 'multipart/form-data',
          params: {
            title: 'title',
            text: 'text',
            url: 'url',
          },
        }
      end

      # Generate screenshots for app stores
      def generate_screenshots
        [
          {
            src: '/assets/screenshot-wide.png',
            sizes: '1280x720',
            type: 'image/png',
            form_factor: 'wide',
          },
          {
            src: '/assets/screenshot-narrow.png',
            sizes: '750x1334',
            type: 'image/png',
            form_factor: 'narrow',
          },
        ]
      end

      # Generate service worker content
      def generate_service_worker
        <<~JAVASCRIPT
          // Astro Blog PWA Service Worker
          // Generated by Zeropoint::PWA

          const CACHE_NAME = 'astro-blog-v1';
          const urlsToCache = [
            '/',
            '/zeropoint/astro-blog',
            '/astro-blog-manifest.json',
            '/offline.html',
            '/assets/icon-192.png',
            '/assets/icon-512.png'
          ];

          // Install event
          self.addEventListener('install', event => {
            console.log('🌌 Astro Blog PWA Service Worker installing...');
            event.waitUntil(
              caches.open(CACHE_NAME)
                .then(cache => {
                  console.log('🌌 Caching app shell');
                  return cache.addAll(urlsToCache);
                })
                .then(() => {
                  console.log('🌌 Service Worker installed successfully');
                  return self.skipWaiting();
                })
            );
          });

          // Activate event
          self.addEventListener('activate', event => {
            console.log('🌌 Astro Blog PWA Service Worker activating...');
            event.waitUntil(
              caches.keys().then(cacheNames => {
                return Promise.all(
                  cacheNames.map(cacheName => {
                    if (cacheName !== CACHE_NAME) {
                      console.log('🌌 Deleting old cache:', cacheName);
                      return caches.delete(cacheName);
                    }
                  })
                );
              }).then(() => {
                console.log('🌌 Service Worker activated successfully');
                return self.clients.claim();
              })
            );
          });

          // Fetch event
          self.addEventListener('fetch', event => {
            event.respondWith(
              caches.match(event.request)
                .then(response => {
                  // Return cached version or fetch from network
                  return response || fetch(event.request)
                    .then(response => {
                      // Cache successful responses
                      if (response.status === 200) {
                        const responseClone = response.clone();
                        caches.open(CACHE_NAME)
                          .then(cache => cache.put(event.request, responseClone));
                      }
                      return response;
                    })
                    .catch(() => {
                      // Return offline page for navigation requests
                      if (event.request.mode === 'navigate') {
                        return caches.match('/offline.html');
                      }
                    });
                })
            );
          });

          // Background sync
          self.addEventListener('sync', event => {
            console.log('🌌 Background sync:', event.tag);
            if (event.tag === 'background-sync') {
              event.waitUntil(doBackgroundSync());
            }
          });

          // Push notifications
          self.addEventListener('push', event => {
            console.log('🌌 Push notification received');
            const options = {
              body: event.data ? event.data.text() : 'New consciousness content available',
              icon: '/assets/icon-192.png',
              badge: '/assets/icon-192.png',
              vibrate: [100, 50, 100],
              data: {
                dateOfArrival: Date.now(),
                primaryKey: 1
              },
              actions: [
                {
                  action: 'explore',
                  title: 'Explore',
                  icon: '/assets/icon-192.png'
                },
                {
                  action: 'close',
                  title: 'Close',
                  icon: '/assets/icon-192.png'
                }
              ]
            };

            event.waitUntil(
              self.registration.showNotification('🌌 Astro Blog', options)
            );
          });

          // Notification click
          self.addEventListener('notificationclick', event => {
            console.log('🌌 Notification clicked:', event.action);
            event.notification.close();

            if (event.action === 'explore') {
              event.waitUntil(
                clients.openWindow('/zeropoint/astro-blog')
              );
            }
          });

          // Background sync function
          async function doBackgroundSync() {
            try {
              // Sync any pending data
              console.log('🌌 Performing background sync');
              // Add your background sync logic here
            } catch (error) {
              console.error('🌌 Background sync failed:', error);
            }
          }
        JAVASCRIPT
      end

      # Generate offline page content
      def generate_offline_page
        <<~HTML
          <!DOCTYPE html>
          <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>🌌 Offline in Space - Astro Blog</title>
            <style>
              body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
                color: #e2e8f0;
                margin: 0;
                padding: 2rem;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
              }
              .container {
                max-width: 600px;
                padding: 2rem;
                background: rgba(30, 41, 59, 0.8);
                border-radius: 1rem;
                backdrop-filter: blur(10px);
                border: 1px solid rgba(148, 163, 184, 0.1);
              }
              h1 {
                font-size: 3rem;
                margin-bottom: 1rem;
                background: linear-gradient(45deg, #60a5fa, #a78bfa);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
              }
              p {
                font-size: 1.2rem;
                line-height: 1.6;
                margin-bottom: 2rem;
                opacity: 0.9;
              }
              .buttons {
                display: flex;
                gap: 1rem;
                justify-content: center;
                flex-wrap: wrap;
              }
              button {
                background: linear-gradient(45deg, #3b82f6, #8b5cf6);
                color: white;
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 0.5rem;
                font-size: 1rem;
                cursor: pointer;
                transition: transform 0.2s;
              }
              button:hover {
                transform: translateY(-2px);
              }
              .cosmic-particles {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: -1;
              }
              .particle {
                position: absolute;
                width: 2px;
                height: 2px;
                background: #60a5fa;
                border-radius: 50%;
                animation: float 6s ease-in-out infinite;
              }
              @keyframes float {
                0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 1; }
                50% { transform: translateY(-20px) rotate(180deg); opacity: 0.5; }
              }
            </style>
          </head>
          <body>
            <div class="cosmic-particles" id="cosmic-particles"></div>
            <div class="container">
              <h1>🌌 Offline in Space</h1>
              <p>You've ventured beyond the cosmic network. Fear not, for consciousness transcends connectivity.</p>
              <div class="buttons">
                <button onclick="window.location.reload()">🔄 Retry Connection</button>
                <button onclick="history.back()">← Go Back</button>
                <button onclick="window.location.href='/'">🏠 Return Home</button>
              </div>
            </div>
            <script>
              // Generate cosmic particles
              const particlesContainer = document.getElementById('cosmic-particles');
              for (let i = 0; i < 50; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.top = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 6 + 's';
                particle.style.animationDuration = (Math.random() * 3 + 3) + 's';
                particlesContainer.appendChild(particle);
              }
            </script>
          </body>
          </html>
        HTML
      end

      # Validate PWA configuration
      def validate_pwa_config
        errors = []

        # Validate required config keys
        required_keys = %w[name short_name description start_url display background_color theme_color]
        required_keys.each do |key|
          errors << "Missing required PWA config: #{key}" unless pwa_config[key.to_sym]
        end

        # Validate routes
        pwa_routes.each do |name, path|
          errors << "Invalid route path for #{name}: #{path}" unless path.start_with?('/')
        end

        # Validate Stimulus controllers
        stimulus_controllers.each do |name, config|
          errors << "Missing targets for Stimulus controller: #{name}" unless config[:targets]
          errors << "Missing actions for Stimulus controller: #{name}" unless config[:actions]
        end

        # Validate backend endpoints
        backend_endpoints.each do |name, config|
          errors << "Missing method for endpoint: #{name}" unless config[:method]
          errors << "Missing path for endpoint: #{name}" unless config[:path]
          errors << "Missing response keys for endpoint: #{name}" unless config[:response_keys]
        end

        errors
      end

      # Get PWA status
      def pwa_status
        {
          configured: pwa_config.present?,
          routes_defined: pwa_routes.present?,
          controllers_defined: stimulus_controllers.present?,
          endpoints_defined: backend_endpoints.present?,
          validation_errors: validate_pwa_config,
        }
      end

      # Generate UUID for PWA interactions
      def generate_pwa_uuid(action, component = 'pwa')
        UuidMatrix.generate({
          action: action,
          component: component,
          state: 'active',
          vortex: 'flowing',
          consciousness: 'expanding',
        })
      end

      # Log PWA interaction
      def log_pwa_interaction(action, details = {})
        uuid = generate_pwa_uuid(action)
        Rails.logger.info("🌌 PWA Interaction: #{action} - UUID: #{uuid} - Details: #{details}")
        { uuid: uuid, action: action, details: details }
      end
    end

    # Instance methods for PWA functionality
    def pwa_manifest
      self.class.generate_manifest
    end

    def pwa_service_worker
      self.class.generate_service_worker
    end

    def pwa_offline_page
      self.class.generate_offline_page
    end

    def pwa_uuid(action, component = 'pwa')
      self.class.generate_pwa_uuid(action, component)
    end

    def log_pwa_action(action, details = {})
      self.class.log_pwa_interaction(action, details)
    end
  end
end
