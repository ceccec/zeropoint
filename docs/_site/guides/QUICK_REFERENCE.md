# Zeropoint Universal Matrix - Quick Reference Guide

## 🚀 Quick Start Commands

```bash
# Start development server
python3 -m http.server 8000

# Access main portal
open http://localhost:8000/index.html

# Access universal matrix demo
open http://localhost:8000/universal_matrix_demo.html
```

## 📋 Framework Integration Patterns

### Stimulus Controller Template
```javascript
class FrameworkController {
  static targets = ["element", "content"]
  static values = { 
    config: Object,
    state: String
  }

  connect() {
    console.log("Controller connected")
    this.initializeFramework()
  }

  disconnect() {
    console.log("Controller disconnected")
    this.cleanup()
  }

  initializeFramework() {
    // Framework initialization code
  }

  cleanup() {
    // Cleanup code
  }
}
```

### Framework Detection Pattern
```javascript
// Check if framework is available
if (window.frameworkName) {
  // Framework is loaded
  this.initializeFramework()
} else {
  console.warn('Framework not available')
}
```

## 🎨 CSS Animation Classes

### Matrix Effects
```css
.matrix-rain { animation: matrix-rain 3s linear infinite; }
.quantum-pulse { animation: quantum-pulse 2s ease-in-out infinite; }
.vortex-spin { animation: vortex-spin 10s linear infinite; }
.consciousness-wave { animation: consciousness-wave 3s ease-in-out infinite; }
.intelligence-glow { animation: intelligence-glow 4s ease-in-out infinite; }
.cosmic-drift { animation: cosmic-drift 20s ease-in-out infinite; }
.hologram-flicker { animation: hologram-flicker 2s ease-in-out infinite; }
```

### Text Effects
```css
.matrix-text { color: #00ff00; text-shadow: 0 0 10px #00ff00; }
.quantum-text { color: #3b82f6; text-shadow: 0 0 10px #3b82f6; }
.consciousness-text { color: #10b981; text-shadow: 0 0 10px #10b981; }
.intelligence-text { color: #f59e0b; text-shadow: 0 0 10px #f59e0b; }
.vortex-text { color: #8b5cf6; text-shadow: 0 0 10px #8b5cf6; }
.cosmic-text { background: linear-gradient(45deg, #667eea, #764ba2, #f093fb, #f5576c); }
.hologram-text { color: #00ffff; text-shadow: 0 0 15px #00ffff; }
```

## 🔧 Common Framework Integrations

### GSAP Animations
```javascript
// Basic GSAP animation
gsap.to(element, { duration: 1, x: 100, y: 100 })

// Timeline animation
const tl = gsap.timeline()
tl.to(element, { duration: 1, x: 100 })
  .to(element, { duration: 1, y: 100 })

// Scroll-triggered animation
gsap.to(element, {
  scrollTrigger: {
    trigger: element,
    start: "top center",
    end: "bottom center",
    scrub: true
  },
  y: 100
})
```

### Three.js Setup
```javascript
// Basic Three.js scene
const scene = new THREE.Scene()
const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)
const renderer = new THREE.WebGLRenderer({ alpha: true })

// Animation loop
function animate() {
  requestAnimationFrame(animate)
  renderer.render(scene, camera)
}
animate()
```

### Particles.js Configuration
```javascript
particlesJS('particles-js', {
  particles: {
    number: { value: 80 },
    color: { value: '#00ffff' },
    shape: { type: 'circle' },
    move: { enable: true, speed: 6 }
  },
  interactivity: {
    events: {
      onhover: { enable: true, mode: 'repulse' }
    }
  }
})
```

### Alpine.js Integration
```javascript
// Initialize Alpine.js data
this.element.setAttribute('x-data', '{ count: 0, items: [] }')

// Update Alpine.js data
this.element.__x.$data.count++

// Trigger Alpine.js events
this.element.dispatchEvent(new CustomEvent('alpine-event'))
```

## 📱 Portal Configuration

### Portal Object Structure
```javascript
const portal = {
  title: 'Demo Title',
  description: 'Demo description',
  icon: '🎮',
  color: 'quantum-text',
  animation: 'quantum-pulse',
  url: 'demo.html',
  features: ['Feature 1', 'Feature 2'],
  complexity: 8,
  frameworks: ['Stimulus', 'Framework Name']
}
```

### Portal Categories
- **Animation**: GSAP, Framer Motion, Lottie
- **3D Graphics**: Three.js, Vanilla Tilt
- **Interactivity**: Alpine.js, Particles.js
- **UX/Scrolling**: AOS, Rellax, Typed.js

## 🎯 Performance Patterns

### Lazy Loading
```javascript
async loadFramework() {
  if (!this.frameworkLoaded) {
    await import('./framework.js')
    this.frameworkLoaded = true
  }
}
```

### Debouncing
```javascript
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
```

### Error Handling
```javascript
try {
  this.initializeFramework()
} catch (error) {
  console.error('Framework failed:', error)
  this.fallbackToBasicMode()
}
```

## 🔍 Browser API Access

### Common Browser APIs
```javascript
// Storage
localStorage.setItem('key', 'value')
sessionStorage.getItem('key')
document.cookie

// Device Info
navigator.userAgent
navigator.platform
navigator.language
screen.width
screen.height

// Performance
performance.now()
performance.memory

// Network
navigator.onLine
navigator.connection

// Geolocation
navigator.geolocation.getCurrentPosition()

// Media Devices
navigator.mediaDevices.enumerateDevices()
```

## 🧪 Testing Patterns

### Framework Testing
```javascript
describe('Framework Integration', () => {
  beforeEach(() => {
    // Setup test environment
  })

  test('Framework initializes correctly', () => {
    expect(framework).toBeDefined()
  })

  test('Animations work as expected', () => {
    // Test animation functionality
  })
})
```

### Performance Testing
```javascript
// Measure execution time
performance.mark('start')
// Execute code
performance.mark('end')
performance.measure('execution', 'start', 'end')
```

## 🚀 Deployment Checklist

### Production Build
- [ ] Minify JavaScript and CSS
- [ ] Optimize images
- [ ] Enable compression (Gzip/Brotli)
- [ ] Set up caching headers
- [ ] Test on multiple browsers
- [ ] Validate performance metrics

### Environment Variables
```javascript
const config = {
  development: { debug: true, frameworks: ['all'] },
  production: { debug: false, frameworks: ['essential'] }
}
```

## 📊 Performance Targets

### Core Web Vitals
- **LCP**: < 2.5s
- **FID**: < 100ms
- **CLS**: < 0.1

### Framework Load Times
- **Stimulus**: < 50ms
- **Tailwind CSS**: < 100ms
- **Three.js**: < 200ms
- **GSAP**: < 150ms

## 🔧 Debugging Tips

### Console Logging
```javascript
console.log('Framework loaded:', framework)
console.warn('Framework not available')
console.error('Framework failed:', error)
```

### Performance Monitoring
```javascript
// Monitor frame rate
let frameCount = 0
function monitorFPS() {
  frameCount++
  if (frameCount % 60 === 0) {
    console.log('FPS:', frameCount / (Date.now() - startTime) * 1000)
  }
}
```

### Memory Usage
```javascript
// Check memory usage
if (performance.memory) {
  console.log('Memory used:', performance.memory.usedJSHeapSize)
  console.log('Memory total:', performance.memory.totalJSHeapSize)
}
```

## 📚 Additional Resources

### Documentation Links
- [Stimulus Documentation](https://stimulus.hotwired.dev/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [GSAP Documentation](https://greensock.com/docs/)
- [Three.js Documentation](https://threejs.org/docs/)
- [Alpine.js Documentation](https://alpinejs.dev/docs/)

### Browser Support
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

---

**Quick Reference** - Zeropoint Universal Matrix Framework Integration Guide 