#!/bin/bash

# GraphQL UI Layout Gem Setup Script
# This script helps you set up the GraphQL UI Layout gem with your chosen bundle

set -e

echo "🚀 GraphQL UI Layout Gem Setup"
echo "=============================="

# Function to display usage
show_usage() {
    echo "Usage: $0 [bundle]"
    echo ""
    echo "Available bundles:"
    echo "  minimal    - Basic setup with essential gems only"
    echo "  essential  - Standard business application setup"
    echo "  complete   - Full-featured setup with all gems"
    echo ""
    echo "Examples:"
    echo "  $0 minimal"
    echo "  $0 essential"
    echo "  $0 complete"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check prerequisites
check_prerequisites() {
    echo "📋 Checking prerequisites..."
    
    if ! command_exists ruby; then
        echo "❌ Ruby is not installed. Please install Ruby 3.0+ first."
        exit 1
    fi
    
    if ! command_exists bundle; then
        echo "❌ Bundler is not installed. Please install Bundler first."
        echo "   Run: gem install bundler"
        exit 1
    fi
    
    if ! command_exists rails; then
        echo "❌ Rails is not installed. Please install Rails first."
        echo "   Run: gem install rails"
        exit 1
    fi
    
    echo "✅ Prerequisites check passed"
}

# Function to setup minimal bundle
setup_minimal() {
    echo "📦 Setting up minimal bundle..."
    
    cp Gemfile.minimal Gemfile
    bundle install
    
    echo "✅ Minimal bundle installed"
}

# Function to setup essential bundle
setup_essential() {
    echo "📦 Setting up essential bundle..."
    
    cp Gemfile.essential Gemfile
    bundle install
    
    echo "✅ Essential bundle installed"
}

# Function to setup complete bundle
setup_complete() {
    echo "📦 Setting up complete bundle..."
    
    # The complete Gemfile is already in place
    bundle install
    
    echo "✅ Complete bundle installed"
}

# Function to setup services
setup_services() {
    echo "🔧 Setting up required services..."
    
    # Check if Redis is installed
    if ! command_exists redis-server; then
        echo "⚠️  Redis is not installed. Please install Redis:"
        echo "   macOS: brew install redis"
        echo "   Ubuntu: sudo apt-get install redis-server"
        echo "   CentOS: sudo yum install redis"
    else
        echo "✅ Redis is available"
    fi
    
    # Check if PostgreSQL is installed
    if ! command_exists psql; then
        echo "⚠️  PostgreSQL is not installed. Please install PostgreSQL:"
        echo "   macOS: brew install postgresql"
        echo "   Ubuntu: sudo apt-get install postgresql postgresql-contrib"
        echo "   CentOS: sudo yum install postgresql postgresql-server"
    else
        echo "✅ PostgreSQL is available"
    fi
    
    # For complete bundle, check Elasticsearch
    if [ "$1" = "complete" ]; then
        if ! command_exists elasticsearch; then
            echo "⚠️  Elasticsearch is not installed. Please install Elasticsearch:"
            echo "   macOS: brew install elasticsearch"
            echo "   Or download from: https://www.elastic.co/downloads/elasticsearch"
        else
            echo "✅ Elasticsearch is available"
        fi
    fi
}

# Function to generate initial configuration
generate_config() {
    echo "⚙️  Generating initial configuration..."
    
    # Create config directory if it doesn't exist
    mkdir -p config/initializers
    
    # Generate GraphQL UI Layout configuration
    cat > config/initializers/zeropoint.rb << 'EOF'
# GraphQL UI Layout Configuration
Zeropoint.configure do |config|
  # Enable features
  config.features = [:navigation, :sidebar, :content_areas, :widgets, :actions, :offline]
  
  # Theme configuration
  config.theme = {
    primary_color: "#667eea",
    secondary_color: "#764ba2",
    accent_color: "#007bff",
    success_color: "#28a745",
    warning_color: "#ffc107",
    danger_color: "#dc3545",
    info_color: "#17a2b8",
    light_color: "#f8f9fa",
    dark_color: "#343a40",
    font_family: "system-ui, -apple-system, sans-serif",
    border_radius: "8px",
    box_shadow: "0 2px 4px rgba(0,0,0,0.1)",
    transition: "all 0.3s ease"
  }
  
  # App configuration
  config.app_config = {
    app_name: Rails.application.class.module_parent_name,
    app_version: "1.0.0",
    api_version: "v1",
    default_locale: I18n.default_locale,
    supported_locales: I18n.available_locales,
    timezone: Time.zone.name,
    date_format: "%Y-%m-%d",
    time_format: "%H:%M:%S",
    pagination: {
      default_per_page: 20,
      max_per_page: 100,
      page_param: "page",
      per_page_param: "per_page"
    },
    search: {
      default_search_type: "auto",
      search_types: ["full_text", "weighted", "fuzzy", "tags", "exact", "auto"],
      min_query_length: 2,
      max_suggestions: 10
    },
    cache: {
      default_ttl: 3600,
      max_ttl: 86400,
      cache_prefix: "ui_layout"
    },
    offline: {
      enabled: true,
      max_cache_size: "50MB",
      sync_interval: 300,
      background_sync: true
    }
  }
  
  # Custom permission checker (optional)
  # config.permission_checker = ->(user, action, resource) {
  #   user&.can?(action, resource)
  # }
end
EOF

    echo "✅ Configuration generated at config/initializers/zeropoint.rb"
}

# Function to create sample models
create_sample_models() {
    echo "📝 Creating sample models..."
    
    # Create User model if it doesn't exist
    if [ ! -f app/models/user.rb ]; then
        cat > app/models/user.rb << 'EOF'
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  rolify
  acts_as_taggable_on :skills, :interests
  
  def can?(action, resource)
    # Implement your permission logic here
    roles.any? { |role| role.permissions.include?("#{action}_#{resource}") }
  end
end
EOF
        echo "✅ User model created"
    fi
    
    # Create Post model if it doesn't exist
    if [ ! -f app/models/post.rb ]; then
        cat > app/models/post.rb << 'EOF'
class Post < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags
  
  validates :title, presence: true
  validates :content, presence: true
  
  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }
end
EOF
        echo "✅ Post model created"
    fi
}

# Function to create sample GraphQL types
create_sample_graphql() {
    echo "🔗 Creating sample GraphQL types..."
    
    # Create GraphQL directory structure
    mkdir -p app/graphql/types
    
    # Create base types if they don't exist
    if [ ! -f app/graphql/types/base_object.rb ]; then
        cat > app/graphql/types/base_object.rb << 'EOF'
module Types
  class BaseObject < GraphQL::Schema::Object
  end
end
EOF
        echo "✅ Base GraphQL types created"
    fi
    
    # Create query type if it doesn't exist
    if [ ! -f app/graphql/types/query_type.rb ]; then
        cat > app/graphql/types/query_type.rb << 'EOF'
module Types
  class QueryType < Types::BaseObject
    field :ui_layout, Types::UiLayoutType, null: false do
      argument :page, String, required: false
    end
    
    def ui_layout(page: "home")
      # The GraphQL UI Layout gem handles this
      Zeropoint::Graphql::Resolvers::UiLayoutResolver.new(
        object: nil, 
        context: context, 
        field: nil
      ).resolve(page: page)
    end
  end
end
EOF
        echo "✅ Query type created"
    fi
}

# Function to create sample view
create_sample_view() {
    echo "🎨 Creating sample view..."
    
    # Create views directory if it doesn't exist
    mkdir -p app/views/layouts
    mkdir -p app/views/pages
    
    # Create application layout if it doesn't exist
    if [ ! -f app/views/layouts/application.html.erb ]; then
        cat > app/views/layouts/application.html.erb << 'EOF'
<!DOCTYPE html>
<html>
  <head>
    <title>GraphQL UI Layout Demo</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body>
    <div data-controller="ui-layout" 
         data-ui-layout-page-value="<%= params[:page] || 'home' %>"
         data-ui-layout-endpoint-value="/graphql">
      
      <nav data-ui-layout-target="navigation" class="ui-layout-navigation"></nav>
      
      <div class="ui-layout-container">
        <aside data-ui-layout-target="sidebar" class="ui-layout-sidebar"></aside>
        <main data-ui-layout-target="content" class="ui-layout-content">
          <%= yield %>
        </main>
      </div>
      
      <div data-ui-layout-target="widgets" class="ui-layout-widgets"></div>
      <div data-ui-layout-target="actions" class="ui-layout-actions"></div>
    </div>
  </body>
</html>
EOF
        echo "✅ Application layout created"
    fi
    
    # Create home page if it doesn't exist
    if [ ! -f app/views/pages/home.html.erb ]; then
        cat > app/views/pages/home.html.erb << 'EOF'
<div class="container mx-auto px-4 py-8">
  <h1 class="text-3xl font-bold mb-6">Welcome to GraphQL UI Layout</h1>
  
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    <div class="bg-white rounded-lg shadow p-6">
      <h2 class="text-xl font-semibold mb-4">Navigation</h2>
      <p class="text-gray-600">Dynamic navigation will be loaded here via GraphQL.</p>
    </div>
    
    <div class="bg-white rounded-lg shadow p-6">
      <h2 class="text-xl font-semibold mb-4">Sidebar</h2>
      <p class="text-gray-600">Dynamic sidebar will be loaded here via GraphQL.</p>
    </div>
    
    <div class="bg-white rounded-lg shadow p-6">
      <h2 class="text-xl font-semibold mb-4">Widgets</h2>
      <p class="text-gray-600">Dynamic widgets will be loaded here via GraphQL.</p>
    </div>
  </div>
</div>
EOF
        echo "✅ Home page created"
    fi
}

# Function to run setup
run_setup() {
    local bundle_type=$1
    
    echo "🎯 Setting up GraphQL UI Layout with $bundle_type bundle..."
    
    # Check prerequisites
    check_prerequisites
    
    # Setup chosen bundle
    case $bundle_type in
        "minimal")
            setup_minimal
            ;;
        "essential")
            setup_essential
            ;;
        "complete")
            setup_complete
            ;;
        *)
            echo "❌ Invalid bundle type: $bundle_type"
            show_usage
            exit 1
            ;;
    esac
    
    # Setup services
    setup_services $bundle_type
    
    # Generate configuration
    generate_config
    
    # Create sample models
    create_sample_models
    
    # Create sample GraphQL types
    create_sample_graphql
    
    # Create sample view
    create_sample_view
    
    echo ""
    echo "🎉 Setup complete!"
    echo ""
    echo "Next steps:"
    echo "1. Start your database:"
    echo "   rails db:create db:migrate"
    echo ""
    echo "2. Start Redis (if not already running):"
    echo "   redis-server"
    echo ""
    echo "3. Start your Rails server:"
    echo "   rails server"
    echo ""
    echo "4. Visit http://localhost:3000 to see your application"
    echo ""
    echo "📚 For more information, see GEM_BUNDLES.md"
}

# Main script logic
if [ $# -eq 0 ]; then
    echo "❌ No bundle type specified"
    show_usage
    exit 1
fi

run_setup $1 