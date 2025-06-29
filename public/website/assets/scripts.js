// Zero Point Website Scripts
document.addEventListener('DOMContentLoaded', function() {
    
    // Smooth scrolling for navigation links
    const navLinks = document.querySelectorAll('a[href^="#"]');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                const offsetTop = targetSection.offsetTop - 70; // Account for fixed navbar
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Navbar scroll effect
    const navbar = document.querySelector('.navbar');
    let lastScrollTop = 0;
    
    window.addEventListener('scroll', function() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (scrollTop > 100) {
            navbar.style.background = 'rgba(255, 255, 255, 0.98)';
            navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.1)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.95)';
            navbar.style.boxShadow = 'none';
        }
        
        lastScrollTop = scrollTop;
    });

    // Mobile navigation toggle
    const navToggle = document.querySelector('.nav-toggle');
    const navLinksContainer = document.querySelector('.nav-links');
    
    if (navToggle) {
        navToggle.addEventListener('click', function() {
            navLinksContainer.classList.toggle('active');
            navToggle.classList.toggle('active');
        });
    }

    // Intersection Observer for animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);

    // Observe elements for animation
    const animateElements = document.querySelectorAll('.feature-card, .doc-card, .code-block');
    animateElements.forEach(el => {
        observer.observe(el);
    });

    // Cosmic flow particles animation
    function createCosmicParticle() {
        const particle = document.createElement('div');
        particle.className = 'cosmic-particle';
        particle.style.cssText = `
            position: fixed;
            width: 2px;
            height: 2px;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border-radius: 50%;
            pointer-events: none;
            z-index: 1;
            opacity: 0;
            animation: particleFloat 3s linear forwards;
        `;
        
        particle.style.left = Math.random() * window.innerWidth + 'px';
        particle.style.top = window.innerHeight + 'px';
        
        document.body.appendChild(particle);
        
        setTimeout(() => {
            if (particle.parentNode) {
                particle.parentNode.removeChild(particle);
            }
        }, 3000);
    }

    // Create cosmic particles periodically
    setInterval(createCosmicParticle, 2000);

    // Add particle animation CSS
    const style = document.createElement('style');
    style.textContent = `
        @keyframes particleFloat {
            0% {
                transform: translateY(0) scale(0);
                opacity: 0;
            }
            10% {
                opacity: 0.8;
                transform: translateY(-10px) scale(1);
            }
            90% {
                opacity: 0.8;
            }
            100% {
                transform: translateY(-100vh) scale(0);
                opacity: 0;
            }
        }
        
        .animate-in {
            animation: slideInUp 0.6s ease-out forwards;
        }
        
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .nav-links.active {
            display: flex;
            flex-direction: column;
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            padding: 1rem;
            border-top: 1px solid var(--gray-200);
        }
        
        .nav-toggle.active span:nth-child(1) {
            transform: rotate(45deg) translate(5px, 5px);
        }
        
        .nav-toggle.active span:nth-child(2) {
            opacity: 0;
        }
        
        .nav-toggle.active span:nth-child(3) {
            transform: rotate(-45deg) translate(7px, -6px);
        }
    `;
    document.head.appendChild(style);

    // Parallax effect for hero section
    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        const hero = document.querySelector('.hero');
        const cosmicFlow = document.querySelector('.cosmic-flow');
        
        if (hero && cosmicFlow) {
            const rate = scrolled * -0.5;
            cosmicFlow.style.transform = `translateY(${rate}px)`;
        }
    });

    // Typing effect for hero title
    function typeWriter(element, text, speed = 100) {
        let i = 0;
        element.innerHTML = '';
        
        function type() {
            if (i < text.length) {
                element.innerHTML += text.charAt(i);
                i++;
                setTimeout(type, speed);
            }
        }
        
        type();
    }

    // Initialize typing effect when hero is visible
    const heroTitle = document.querySelector('.hero-title');
    if (heroTitle) {
        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const originalText = heroTitle.textContent;
                    typeWriter(heroTitle, originalText, 50);
                    observer.unobserve(entry.target);
                }
            });
        });
        observer.observe(heroTitle);
    }

    // Stats counter animation
    function animateCounter(element, target, duration = 2000) {
        const start = 0;
        const increment = target / (duration / 16);
        let current = start;
        
        const timer = setInterval(() => {
            current += increment;
            if (current >= target) {
                current = target;
                clearInterval(timer);
            }
            
            if (element.textContent === '∞') {
                return; // Don't animate infinity symbol
            }
            
            element.textContent = Math.floor(current);
        }, 16);
    }

    // Animate stats when they come into view
    const statNumbers = document.querySelectorAll('.stat-number');
    const statsObserver = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const element = entry.target;
                const text = element.textContent;
                
                if (text.includes('%')) {
                    const number = parseInt(text);
                    animateCounter(element, number);
                } else if (text.includes('x')) {
                    const number = parseFloat(text);
                    animateCounter(element, number * 10, 1000);
                }
                
                statsObserver.unobserve(entry.target);
            }
        });
    });
    
    statNumbers.forEach(stat => {
        statsObserver.observe(stat);
    });

    // Code block syntax highlighting
    function highlightCode() {
        const codeBlocks = document.querySelectorAll('pre code');
        codeBlocks.forEach(block => {
            const text = block.textContent;
            
            // Simple syntax highlighting for Ruby
            const highlighted = text
                .replace(/\b(gem|class|def|end|include|require|module)\b/g, '<span style="color: #ff6b6b;">$1</span>')
                .replace(/\b(true|false|nil)\b/g, '<span style="color: #4ecdc4;">$1</span>')
                .replace(/\b(if|else|elsif|unless|case|when|then)\b/g, '<span style="color: #45b7d1;">$1</span>')
                .replace(/\b(do|end|begin|rescue|ensure)\b/g, '<span style="color: #96ceb4;">$1</span>')
                .replace(/\b(attr_accessor|attr_reader|attr_writer)\b/g, '<span style="color: #feca57;">$1</span>')
                .replace(/\b(ApplicationController|ApplicationRecord)\b/g, '<span style="color: #ff9ff3;">$1</span>')
                .replace(/\b(zeropoint_stream|zeropoint_realtime)\b/g, '<span style="color: #54a0ff;">$1</span>')
                .replace(/\b(params|response|request)\b/g, '<span style="color: #5f27cd;">$1</span>')
                .replace(/\b(@\w+)\b/g, '<span style="color: #00d2d3;">$1</span>')
                .replace(/\b(\d+)\b/g, '<span style="color: #ff9f43;">$1</span>')
                .replace(/\b(".*?")\b/g, '<span style="color: #10ac84;">$1</span>')
                .replace(/\b(:[a-zA-Z_]\w*)\b/g, '<span style="color: #ff6348;">$1</span>');
            
            block.innerHTML = highlighted;
        });
    }

    // Initialize syntax highlighting
    highlightCode();

    // Performance optimization: Debounce scroll events
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    // Apply debouncing to scroll events
    const debouncedScrollHandler = debounce(function() {
        // Scroll-based animations and effects
    }, 16);

    window.addEventListener('scroll', debouncedScrollHandler);

    // Add loading animation
    window.addEventListener('load', function() {
        document.body.classList.add('loaded');
    });

    // Add loading class CSS
    const loadingStyle = document.createElement('style');
    loadingStyle.textContent = `
        body:not(.loaded) {
            overflow: hidden;
        }
        
        body:not(.loaded)::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--gradient-hero);
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        body:not(.loaded)::after {
            content: '🌌';
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 4rem;
            z-index: 10000;
            animation: cosmic-float 2s ease-in-out infinite;
        }
    `;
    document.head.appendChild(loadingStyle);

    // Console welcome message
    console.log(`
    🌌 Welcome to Zero Point! 🌌
    
    From the void, all things emerge.
    From zero, infinity flows.
    
    Explore the cosmic data architecture at:
    https://github.com/ceccec/zeropoint
    
    May your data streams flow infinitely! ✨
    `);

    // Easter egg: Konami code
    let konamiCode = [];
    const konamiSequence = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65]; // ↑↑↓↓←→←→BA
    
    document.addEventListener('keydown', function(e) {
        konamiCode.push(e.keyCode);
        
        if (konamiCode.length > konamiSequence.length) {
            konamiCode.shift();
        }
        
        if (konamiCode.join(',') === konamiSequence.join(',')) {
            // Trigger cosmic mode
            document.body.classList.add('cosmic-mode');
            
            // Add cosmic mode styles
            const cosmicStyle = document.createElement('style');
            cosmicStyle.textContent = `
                .cosmic-mode {
                    animation: cosmicPulse 2s ease-in-out infinite;
                }
                
                @keyframes cosmicPulse {
                    0%, 100% { filter: hue-rotate(0deg); }
                    50% { filter: hue-rotate(180deg); }
                }
                
                .cosmic-mode * {
                    animation: cosmicFloat 3s ease-in-out infinite;
                }
            `;
            document.head.appendChild(cosmicStyle);
            
            // Show cosmic message
            setTimeout(() => {
                alert('🌌 Cosmic mode activated! The universe flows through you! 🌌');
            }, 1000);
            
            konamiCode = [];
        }
    });
}); 