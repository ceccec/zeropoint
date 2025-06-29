// Astro Blog PWA Service Worker
// Handles caching, offline functionality, and background sync

const CACHE_NAME = 'astro-blog-v1'
const STATIC_CACHE = 'astro-blog-static-v1'
const DYNAMIC_CACHE = 'astro-blog-dynamic-v1'

// Files to cache immediately
const STATIC_FILES = [
  '/',
  '/astro-blog-manifest.json',
  '/assets/favicon.svg',
  '/assets/icon-192.png',
  '/assets/icon-512.png',
  'https://cdn.tailwindcss.com',
  'https://unpkg.com/@hotwired/stimulus@3.2.2/dist/stimulus.js'
]

// Install event - cache static files
self.addEventListener('install', (event) => {
  console.log('🌌 Astro Blog SW: Installing...')
  
  event.waitUntil(
    caches.open(STATIC_CACHE)
      .then(cache => {
        console.log('🌌 Astro Blog SW: Caching static files')
        return cache.addAll(STATIC_FILES)
      })
      .then(() => {
        console.log('🌌 Astro Blog SW: Static files cached')
        return self.skipWaiting()
      })
  )
})

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  console.log('🌌 Astro Blog SW: Activating...')
  
  event.waitUntil(
    caches.keys()
      .then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => {
            if (cacheName !== STATIC_CACHE && cacheName !== DYNAMIC_CACHE) {
              console.log('🌌 Astro Blog SW: Deleting old cache:', cacheName)
              return caches.delete(cacheName)
            }
          })
        )
      })
      .then(() => {
        console.log('🌌 Astro Blog SW: Activated and ready')
        return self.clients.claim()
      })
  )
})

// Fetch event - serve from cache or network
self.addEventListener('fetch', (event) => {
  const { request } = event
  const url = new URL(request.url)
  
  // Skip non-GET requests
  if (request.method !== 'GET') {
    return
  }
  
  // Handle different types of requests
  if (url.pathname.startsWith('/api/')) {
    // API requests - network first, cache fallback
    event.respondWith(handleApiRequest(request))
  } else if (url.pathname.startsWith('/assets/')) {
    // Asset requests - cache first, network fallback
    event.respondWith(handleAssetRequest(request))
  } else {
    // Page requests - network first, cache fallback
    event.respondWith(handlePageRequest(request))
  }
})

// Handle API requests
async function handleApiRequest(request) {
  try {
    // Try network first
    const networkResponse = await fetch(request)
    
    // Cache successful responses
    if (networkResponse.ok) {
      const cache = await caches.open(DYNAMIC_CACHE)
      cache.put(request, networkResponse.clone())
    }
    
    return networkResponse
  } catch (error) {
    console.log('🌌 Astro Blog SW: API request failed, trying cache:', request.url)
    
    // Fallback to cache
    const cachedResponse = await caches.match(request)
    if (cachedResponse) {
      return cachedResponse
    }
    
    // Return offline response for API requests
    return new Response(
      JSON.stringify({ 
        error: 'Offline - API not available',
        message: 'Please check your connection and try again'
      }),
      {
        status: 503,
        statusText: 'Service Unavailable',
        headers: { 'Content-Type': 'application/json' }
      }
    )
  }
}

// Handle asset requests
async function handleAssetRequest(request) {
  // Try cache first
  const cachedResponse = await caches.match(request)
  if (cachedResponse) {
    return cachedResponse
  }
  
  try {
    // Fallback to network
    const networkResponse = await fetch(request)
    
    // Cache successful responses
    if (networkResponse.ok) {
      const cache = await caches.open(DYNAMIC_CACHE)
      cache.put(request, networkResponse.clone())
    }
    
    return networkResponse
  } catch (error) {
    console.log('🌌 Astro Blog SW: Asset request failed:', request.url)
    
    // Return a placeholder for missing assets
    if (request.url.includes('.jpg') || request.url.includes('.png')) {
      return new Response(
        '<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="200" fill="#1e293b"/><text x="100" y="100" text-anchor="middle" fill="#60a5fa" font-family="Arial" font-size="16">🌌</text></svg>',
        {
          headers: { 'Content-Type': 'image/svg+xml' }
        }
      )
    }
    
    throw error
  }
}

// Handle page requests
async function handlePageRequest(request) {
  try {
    // Try network first
    const networkResponse = await fetch(request)
    
    // Cache successful responses
    if (networkResponse.ok) {
      const cache = await caches.open(DYNAMIC_CACHE)
      cache.put(request, networkResponse.clone())
    }
    
    return networkResponse
  } catch (error) {
    console.log('🌌 Astro Blog SW: Page request failed, trying cache:', request.url)
    
    // Fallback to cache
    const cachedResponse = await caches.match(request)
    if (cachedResponse) {
      return cachedResponse
    }
    
    // Return offline page
    return caches.match('/offline.html')
  }
}

// Background sync for offline actions
self.addEventListener('sync', (event) => {
  console.log('🌌 Astro Blog SW: Background sync:', event.tag)
  
  if (event.tag === 'astro-blog-sync') {
    event.waitUntil(syncOfflineActions())
  }
})

// Sync offline actions when back online
async function syncOfflineActions() {
  try {
    // Get offline actions from IndexedDB or localStorage
    const offlineActions = await getOfflineActions()
    
    for (const action of offlineActions) {
      try {
        await performOfflineAction(action)
        await removeOfflineAction(action.id)
      } catch (error) {
        console.error('🌌 Astro Blog SW: Failed to sync action:', action, error)
      }
    }
    
    console.log('🌌 Astro Blog SW: Background sync completed')
  } catch (error) {
    console.error('🌌 Astro Blog SW: Background sync failed:', error)
  }
}

// Get offline actions from storage
async function getOfflineActions() {
  // This would typically use IndexedDB
  // For now, return empty array
  return []
}

// Perform an offline action
async function performOfflineAction(action) {
  // This would perform the actual action (e.g., API call)
  console.log('🌌 Astro Blog SW: Performing offline action:', action)
}

// Remove completed offline action
async function removeOfflineAction(actionId) {
  // This would remove the action from storage
  console.log('🌌 Astro Blog SW: Removing offline action:', actionId)
}

// Push notification handling
self.addEventListener('push', (event) => {
  console.log('🌌 Astro Blog SW: Push notification received')
  
  const options = {
    body: event.data ? event.data.text() : 'New cosmic discovery awaits!',
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
  }
  
  event.waitUntil(
    self.registration.showNotification('🌌 Astro Blog', options)
  )
})

// Notification click handling
self.addEventListener('notificationclick', (event) => {
  console.log('🌌 Astro Blog SW: Notification clicked:', event.action)
  
  event.notification.close()
  
  if (event.action === 'explore') {
    event.waitUntil(
      clients.openWindow('/')
    )
  }
})

// Message handling from main thread
self.addEventListener('message', (event) => {
  console.log('🌌 Astro Blog SW: Message received:', event.data)
  
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting()
  }
  
  if (event.data && event.data.type === 'CACHE_URLS') {
    event.waitUntil(
      caches.open(DYNAMIC_CACHE)
        .then(cache => cache.addAll(event.data.urls))
    )
  }
}) 