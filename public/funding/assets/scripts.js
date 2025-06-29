// Zero Point Funding Page Scripts
// Cosmic interactions and animations

document.addEventListener('DOMContentLoaded', function() {
    // Initialize cosmic effects
    initCosmicEffects();
    
    // Initialize scroll animations
    initScrollAnimations();
    
    // Initialize particle system
    initParticleSystem();
    
    // Initialize funding interactions
    initFundingInteractions();
});

// Cosmic Effects
function initCosmicEffects() {
    // Add cosmic glow to funding cards
    const fundingCards = document.querySelectorAll('.funding-card, .donation-card, .alternative-card, .impact-card');
    
    fundingCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.boxShadow = '0 0 50px rgba(107, 33, 168, 0.4)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.boxShadow = '';
        });
    });
    
    // Add cosmic pulse to stats
    const statNumbers = document.querySelectorAll('.stat-number');
    statNumbers.forEach(stat => {
        setInterval(() => {
            stat.style.transform = 'scale(1.1)';
            setTimeout(() => {
                stat.style.transform = 'scale(1)';
            }, 200);
        }, 3000);
    });
}

// Scroll Animations
function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // Observe all cards and sections
    const animatedElements = document.querySelectorAll('.reason-card, .funding-card, .donation-card, .alternative-card, .impact-card');
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
        observer.observe(el);
    });
}

// Particle System
function initParticleSystem() {
    const cosmicFunding = document.querySelector('.cosmic-funding');
    if (!cosmicFunding) return;
    
    // Create additional floating particles
    for (let i = 0; i < 10; i++) {
        createFloatingParticle(cosmicFunding);
    }
}

function createFloatingParticle(container) {
    const particle = document.createElement('div');
    particle.className = 'floating-particle';
    particle.style.cssText = `
        position: absolute;
        width: 4px;
        height: 4px;
        background: linear-gradient(135deg, #6b21a8, #1e40af, #0891b2);
        border-radius: 50%;
        opacity: 0.6;
        pointer-events: none;
    `;
    
    // Random position
    const x = Math.random() * 100;
    const y = Math.random() * 100;
    particle.style.left = x + '%';
    particle.style.top = y + '%';
    
    // Random animation
    const duration = 3 + Math.random() * 4;
    const delay = Math.random() * 2;
    
    particle.style.animation = `particle-float ${duration}s ease-in-out ${delay}s infinite`;
    
    container.appendChild(particle);
    
    // Remove particle after animation
    setTimeout(() => {
        if (particle.parentNode) {
            particle.parentNode.removeChild(particle);
        }
    }, (duration + delay) * 1000);
}

// Funding Interactions
function initFundingInteractions() {
    // Add click tracking for funding buttons
    const fundingButtons = document.querySelectorAll('.funding-button, .donation-button, .alternative-link');
    
    fundingButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            // Add cosmic ripple effect
            createRippleEffect(e);
            
            // Track funding interaction
            trackFundingInteraction(this.textContent.trim());
        });
    });
    
    // Add hover effects for funding amounts
    const fundingAmounts = document.querySelectorAll('.funding-amount, .donation-amount');
    
    fundingAmounts.forEach(amount => {
        amount.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.1)';
            this.style.textShadow = '0 0 20px rgba(5, 150, 105, 0.5)';
        });
        
        amount.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
            this.style.textShadow = '';
        });
    });
}

// Ripple Effect
function createRippleEffect(event) {
    const button = event.currentTarget;
    const ripple = document.createElement('span');
    
    const rect = button.getBoundingClientRect();
    const size = Math.max(rect.width, rect.height);
    const x = event.clientX - rect.left - size / 2;
    const y = event.clientY - rect.top - size / 2;
    
    ripple.style.cssText = `
        position: absolute;
        width: ${size}px;
        height: ${size}px;
        left: ${x}px;
        top: ${y}px;
        background: rgba(255, 255, 255, 0.3);
        border-radius: 50%;
        transform: scale(0);
        animation: ripple 0.6s linear;
        pointer-events: none;
    `;
    
    button.style.position = 'relative';
    button.style.overflow = 'hidden';
    button.appendChild(ripple);
    
    setTimeout(() => {
        if (ripple.parentNode) {
            ripple.parentNode.removeChild(ripple);
        }
    }, 600);
}

// Add ripple animation to CSS
const style = document.createElement('style');
style.textContent = `
    @keyframes ripple {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }
    
    @keyframes particle-float {
        0%, 100% { 
            transform: translateY(0px) translateX(0px);
            opacity: 0.6;
        }
        50% { 
            transform: translateY(-30px) translateX(10px);
            opacity: 1;
        }
    }
`;
document.head.appendChild(style);

// Analytics and Tracking
function trackFundingInteraction(buttonText) {
    // Track funding interactions (you can integrate with your analytics service)
    console.log('Funding interaction:', buttonText);
    
    // Example: Send to analytics service
    if (typeof gtag !== 'undefined') {
        gtag('event', 'funding_click', {
            'event_category': 'funding',
            'event_label': buttonText
        });
    }
}

// Cosmic Background Animation
function initCosmicBackground() {
    const body = document.body;
    
    // Create cosmic background particles
    for (let i = 0; i < 50; i++) {
        createBackgroundParticle();
    }
}

function createBackgroundParticle() {
    const particle = document.createElement('div');
    particle.style.cssText = `
        position: fixed;
        width: 2px;
        height: 2px;
        background: rgba(107, 33, 168, 0.3);
        border-radius: 50%;
        pointer-events: none;
        z-index: -1;
    `;
    
    // Random position
    particle.style.left = Math.random() * 100 + '%';
    particle.style.top = Math.random() * 100 + '%';
    
    // Random animation
    const duration = 10 + Math.random() * 20;
    particle.style.animation = `background-float ${duration}s linear infinite`;
    
    document.body.appendChild(particle);
    
    // Remove and recreate particle
    setTimeout(() => {
        if (particle.parentNode) {
            particle.parentNode.removeChild(particle);
        }
        createBackgroundParticle();
    }, duration * 1000);
}

// Add background animation to CSS
const backgroundStyle = document.createElement('style');
backgroundStyle.textContent = `
    @keyframes background-float {
        0% {
            transform: translateY(100vh) translateX(0);
            opacity: 0;
        }
        10% {
            opacity: 1;
        }
        90% {
            opacity: 1;
        }
        100% {
            transform: translateY(-100px) translateX(100px);
            opacity: 0;
        }
    }
`;
document.head.appendChild(backgroundStyle);

// Initialize background animation
initCosmicBackground();

// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Parallax effect for hero section
window.addEventListener('scroll', function() {
    const scrolled = window.pageYOffset;
    const hero = document.querySelector('.hero');
    const cosmicFunding = document.querySelector('.cosmic-funding');
    
    if (hero && cosmicFunding) {
        const rate = scrolled * -0.5;
        cosmicFunding.style.transform = `translateY(${rate}px) rotate(${scrolled * 0.1}deg)`;
    }
});

// Cosmic loading animation
window.addEventListener('load', function() {
    document.body.classList.add('loaded');
    
    // Add cosmic completion effect
    const completionParticles = document.querySelectorAll('.funding-particle');
    completionParticles.forEach((particle, index) => {
        setTimeout(() => {
            particle.style.animation = 'cosmic-completion 1s ease-out forwards';
        }, index * 100);
    });
});

// Add completion animation to CSS
const completionStyle = document.createElement('style');
completionStyle.textContent = `
    @keyframes cosmic-completion {
        0% {
            transform: scale(1);
            opacity: 1;
        }
        50% {
            transform: scale(2);
            opacity: 0.8;
        }
        100% {
            transform: scale(0);
            opacity: 0;
        }
    }
    
    body.loaded .hero-title .title-line {
        animation-play-state: running;
    }
`;
document.head.appendChild(completionStyle); 