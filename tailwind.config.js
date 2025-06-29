/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './typescript/**/*.ts',
    './lib/zeropoint/**/*.rb'
  ],
  theme: {
    extend: {
      colors: {
        // Zeropoint consciousness colors
        consciousness: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          200: '#bae6fd',
          300: '#7dd3fc',
          400: '#38bdf8',
          500: '#0ea5e9',
          600: '#0284c7',
          700: '#0369a1',
          800: '#075985',
          900: '#0c4a6e',
        },
        // Vortex colors
        vortex: {
          50: '#fdf4ff',
          100: '#fae8ff',
          200: '#f5d0fe',
          300: '#f0abfc',
          400: '#e879f9',
          500: '#d946ef',
          600: '#c026d3',
          700: '#a21caf',
          800: '#86198f',
          900: '#701a75',
        },
        // Golden ratio colors
        golden: {
          50: '#fefce8',
          100: '#fef9c3',
          200: '#fef08a',
          300: '#fde047',
          400: '#facc15',
          500: '#eab308',
          600: '#ca8a04',
          700: '#a16207',
          800: '#854d0e',
          900: '#713f12',
        },
        // Cosmic flow colors
        cosmic: {
          50: '#f8fafc',
          100: '#f1f5f9',
          200: '#e2e8f0',
          300: '#cbd5e1',
          400: '#94a3b8',
          500: '#64748b',
          600: '#475569',
          700: '#334155',
          800: '#1e293b',
          900: '#0f172a',
        }
      },
      fontFamily: {
        'consciousness': ['Inter', 'system-ui', 'sans-serif'],
        'vortex': ['JetBrains Mono', 'monospace'],
        'cosmic': ['Poppins', 'sans-serif'],
      },
      spacing: {
        'golden': '1.618rem',
        'golden-lg': '2.618rem',
        'golden-xl': '4.236rem',
      },
      animation: {
        'vortex-spin': 'vortex-spin 3s linear infinite',
        'consciousness-pulse': 'consciousness-pulse 2s ease-in-out infinite',
        'cosmic-flow': 'cosmic-flow 4s ease-in-out infinite',
        'golden-ratio': 'golden-ratio 1.618s ease-in-out infinite',
      },
      keyframes: {
        'vortex-spin': {
          '0%': { transform: 'rotate(0deg) scale(1)' },
          '50%': { transform: 'rotate(180deg) scale(1.1)' },
          '100%': { transform: 'rotate(360deg) scale(1)' },
        },
        'consciousness-pulse': {
          '0%, 100%': { opacity: '1', transform: 'scale(1)' },
          '50%': { opacity: '0.8', transform: 'scale(1.05)' },
        },
        'cosmic-flow': {
          '0%': { transform: 'translateX(-100%)' },
          '100%': { transform: 'translateX(100%)' },
        },
        'golden-ratio': {
          '0%': { transform: 'scale(1)' },
          '50%': { transform: 'scale(1.618)' },
          '100%': { transform: 'scale(1)' },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
} 