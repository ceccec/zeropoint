#!/bin/bash

# Zero Point Gem Website Deployment Script
# Cosmic deployment for infinite possibilities

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Cosmic ASCII art
echo -e "${PURPLE}"
cat << "EOF"
🌌 Zero Point Gem Website Deployment 🌌
    From void, infinite possibilities emerge
EOF
echo -e "${NC}"

# Configuration
PROJECT_NAME="zeropoint-gem"
DOMAIN="gem.zeropoint.bg"
DEPLOY_DIR="."

# Function to print status
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to validate deployment files
validate_files() {
    print_status "Validating deployment files..."
    
    required_files=("index.html" "assets/styles.css" "assets/scripts.js" "assets/favicon.svg" "sitemap.xml" "robots.txt")
    
    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            print_error "Required file missing: $file"
            exit 1
        fi
    done
    
    print_success "All required files present"
}

# Function to optimize assets
optimize_assets() {
    print_status "Optimizing assets for cosmic performance..."
    
    # Check if optimization tools are available
    if command_exists "html-minifier"; then
        print_status "Minifying HTML..."
        html-minifier --collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --use-short-doctype --minify-css true --minify-js true index.html -o index.html
    fi
    
    if command_exists "cleancss"; then
        print_status "Minifying CSS..."
        cleancss -o assets/styles.css assets/styles.css
    fi
    
    if command_exists "uglifyjs"; then
        print_status "Minifying JavaScript..."
        uglifyjs assets/scripts.js -o assets/scripts.js --compress --mangle
    fi
    
    print_success "Assets optimized"
}

# Function to deploy to Netlify
deploy_netlify() {
    print_status "Deploying to Netlify..."
    
    if ! command_exists "netlify"; then
        print_error "Netlify CLI not found. Install with: npm install -g netlify-cli"
        return 1
    fi
    
    # Check if already logged in
    if ! netlify status >/dev/null 2>&1; then
        print_warning "Please login to Netlify first: netlify login"
        return 1
    fi
    
    # Deploy
    netlify deploy --prod --dir="$DEPLOY_DIR" --message="Cosmic deployment: $(date)"
    
    print_success "Deployed to Netlify"
}

# Function to deploy to Vercel
deploy_vercel() {
    print_status "Deploying to Vercel..."
    
    if ! command_exists "vercel"; then
        print_error "Vercel CLI not found. Install with: npm install -g vercel"
        return 1
    fi
    
    # Deploy
    vercel --prod --confirm
    
    print_success "Deployed to Vercel"
}

# Function to deploy to GitHub Pages
deploy_github_pages() {
    print_status "Deploying to GitHub Pages..."
    
    if ! command_exists "git"; then
        print_error "Git not found"
        return 1
    fi
    
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository"
        return 1
    fi
    
    # Create gh-pages branch if it doesn't exist
    if ! git show-ref --verify --quiet refs/heads/gh-pages; then
        git checkout --orphan gh-pages
        git rm -rf .
    else
        git checkout gh-pages
    fi
    
    # Copy files
    git checkout main -- "$DEPLOY_DIR"
    cp -r "$DEPLOY_DIR"/* .
    rm -rf "$DEPLOY_DIR"
    
    # Add CNAME for custom domain
    echo "$DOMAIN" > CNAME
    
    # Commit and push
    git add .
    git commit -m "Cosmic deployment: $(date)"
    git push origin gh-pages
    
    # Return to main branch
    git checkout main
    
    print_success "Deployed to GitHub Pages"
}

# Function to deploy to Cloudflare Pages
deploy_cloudflare() {
    print_status "Deploying to Cloudflare Pages..."
    
    if ! command_exists "wrangler"; then
        print_error "Wrangler CLI not found. Install with: npm install -g wrangler"
        return 1
    fi
    
    # Deploy
    wrangler pages publish "$DEPLOY_DIR" --project-name="$PROJECT_NAME"
    
    print_success "Deployed to Cloudflare Pages"
}

# Function to test deployment
test_deployment() {
    local url=$1
    print_status "Testing deployment at $url..."
    
    if command_exists "curl"; then
        response=$(curl -s -o /dev/null -w "%{http_code}" "$url")
        if [[ "$response" == "200" ]]; then
            print_success "Deployment test passed (HTTP $response)"
        else
            print_warning "Deployment test returned HTTP $response"
        fi
    else
        print_warning "curl not available, skipping deployment test"
    fi
}

# Function to show help
show_help() {
    echo "Usage: $0 [OPTIONS] [PLATFORM]"
    echo ""
    echo "Options:"
    echo "  -h, --help          Show this help message"
    echo "  -v, --validate      Validate files only"
    echo "  -o, --optimize      Optimize assets only"
    echo "  -t, --test URL      Test deployment at URL"
    echo ""
    echo "Platforms:"
    echo "  netlify             Deploy to Netlify"
    echo "  vercel              Deploy to Vercel"
    echo "  github              Deploy to GitHub Pages"
    echo "  cloudflare          Deploy to Cloudflare Pages"
    echo "  all                 Deploy to all platforms"
    echo ""
    echo "Examples:"
    echo "  $0 netlify          Deploy to Netlify"
    echo "  $0 --validate       Validate files only"
    echo "  $0 --optimize       Optimize assets only"
    echo "  $0 --test https://gem.zeropoint.bg"
}

# Main script
main() {
    local platform=""
    local validate_only=false
    local optimize_only=false
    local test_url=""
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -v|--validate)
                validate_only=true
                shift
                ;;
            -o|--optimize)
                optimize_only=true
                shift
                ;;
            -t|--test)
                test_url="$2"
                shift 2
                ;;
            netlify|vercel|github|cloudflare|all)
                platform="$1"
                shift
                ;;
            *)
                print_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # Change to script directory
    cd "$(dirname "$0")"
    
    # Validate files
    validate_files
    
    if [[ "$validate_only" == true ]]; then
        print_success "Validation complete"
        exit 0
    fi
    
    # Optimize assets
    optimize_assets
    
    if [[ "$optimize_only" == true ]]; then
        print_success "Optimization complete"
        exit 0
    fi
    
    # Test deployment if URL provided
    if [[ -n "$test_url" ]]; then
        test_deployment "$test_url"
        exit 0
    fi
    
    # Deploy based on platform
    case "$platform" in
        netlify)
            deploy_netlify
            ;;
        vercel)
            deploy_vercel
            ;;
        github)
            deploy_github_pages
            ;;
        cloudflare)
            deploy_cloudflare
            ;;
        all)
            print_status "Deploying to all platforms..."
            deploy_netlify || true
            deploy_vercel || true
            deploy_github_pages || true
            deploy_cloudflare || true
            print_success "Deployment to all platforms attempted"
            ;;
        "")
            print_error "No platform specified"
            show_help
            exit 1
            ;;
    esac
    
    print_success "Cosmic deployment complete! 🌌✨"
}

# Run main function
main "$@" 