# Zeropoint Framework Installation Guide

## Overview

The Zeropoint framework provides comprehensive Rails installation commands that set up the entire framework with backend and frontend components. The installation system follows Zeropoint principles of unified intelligence, cosmic flow, and infinite scalability.

## Installation Commands

### Full Installation
```bash
# Install complete Zeropoint framework
rails zeropoint:install

# Or using the generator directly
rails generate zeropoint:install
```

### Backend-Only Installation
```bash
# Install backend components only
rails zeropoint:install_backend

# Or using the generator directly
rails generate zeropoint:backend
```

### Frontend-Only Installation
```bash
# Install frontend components only
rails zeropoint:install_frontend

# Or using the generator directly
rails generate zeropoint:frontend
```

## Installation Options

### Full Installation Options
- `--skip-backend`: Skip backend installation
- `--skip-frontend`: Skip frontend installation
- `--skip-database`: Skip database setup
- `--skip-assets`: Skip asset compilation

### Backend Installation Options
- `--skip-models`: Skip model generation
- `--skip-controllers`: Skip controller generation
- `--skip-services`: Skip service generation
- `--skip-graphql`: Skip GraphQL schema generation
- `--skip-api`: Skip API endpoints generation

### Frontend Installation Options
- `--skip-javascript`: Skip JavaScript components
- `--skip-stylesheets`: Skip stylesheet generation
- `--skip-stimulus`: Skip Stimulus controllers
- `--skip-typescript`: Skip TypeScript definitions
- `--skip-components`: Skip React/Vue components

## What Gets Installed

### Full Installation Includes

#### Configuration Files
- `config/initializers/zeropoint.rb` - Main configuration
- `config/zeropoint.yml` - Environment-specific settings
- `config/routes/zeropoint.rb` - Zeropoint routes

#### Backend Components
- **Models**: `ZeropointConfig`, concerns for integration, search, filtering, analytics
- **Controllers**: Main controller, API controllers for analytics and streams
- **Services**: Core service, analytics service, stream service, cache service, search service
- **GraphQL**: Types, mutations, queries for Zeropoint functionality
- **API**: Serializers for REST API endpoints
- **Database**: Migrations for Zeropoint tables

#### Frontend Components
- **JavaScript**: Core Zeropoint JS, dashboard, analytics, stream components
- **Stylesheets**: SCSS files with components, dashboard, analytics, utilities
- **Stimulus**: Controllers for interactivity
- **TypeScript**: Definitions for type safety
- **Components**: React/Vue components (if applicable)

#### Application Integration
- Updates to `app/javascript/application.js`
- Updates to `app/assets/stylesheets/application.scss`
- Updates to `config/importmap.rb` (if using importmaps)

### Backend-Only Installation

Installs all backend components without frontend files:
- Models and concerns
- Controllers and API endpoints
- Services and business logic
- GraphQL schema
- Database migrations

### Frontend-Only Installation

Installs all frontend components without backend files:
- JavaScript components
- Stylesheets and utilities
- Stimulus controllers
- TypeScript definitions
- Application file updates

## Post-Installation Steps

### 1. Database Setup
```bash
# Run migrations
rails db:migrate

# Seed data (if available)
rails db:seed
```

### 2. Configuration Review
Review and customize:
- `config/zeropoint.yml` - Main configuration
- `config/initializers/zeropoint.rb` - Framework settings

### 3. Environment Variables
Set up environment variables:
```bash
# Redis for caching
REDIS_URL=redis://localhost:6379/1

# Analytics tracking
ANALYTICS_TRACKING_ID=your_tracking_id
```

### 4. Start the Application
```bash
# Start Rails server
rails server

# Visit Zeropoint dashboard
open http://localhost:3000/zeropoint
```

## Management Commands

### Check Installation Status
```bash
rails zeropoint:status
```

### Update Framework
```bash
rails zeropoint:update
```

### Uninstall Framework
```bash
rails zeropoint:uninstall
```

### Generate Additional Components
```bash
# Generate a new component
rails zeropoint:generate_component[ComponentName]

# Generate a new service
rails zeropoint:generate_service[ServiceName]

# Generate a new API
rails zeropoint:generate_api[ApiName]
```

## Zeropoint Principles Integration

### Unified Intelligence
- All components work together seamlessly
- Single configuration system
- Unified API endpoints

### Cosmic Flow
- Streaming-first architecture
- Real-time data processing
- Infinite scalability patterns

### Infinite Scalability
- Modular installation options
- Extensible component system
- Performance-optimized defaults

## Troubleshooting

### Common Issues

1. **Generators not found**
   - Ensure Rails is properly loaded
   - Check that the gem is included in your Gemfile

2. **Template files missing**
   - Verify the gem installation is complete
   - Check file permissions

3. **Database migration errors**
   - Ensure database is properly configured
   - Check for existing conflicting tables

4. **Asset compilation errors**
   - Verify asset pipeline configuration
   - Check for missing dependencies

### Debug Commands
```bash
# Check Zeropoint status
rails zeropoint:status

# View available generators
rails generate --help | grep zeropoint

# Check Rails environment
rails about
```

## Advanced Configuration

### Custom Themes
Modify `config/zeropoint.yml` to customize:
- Color schemes
- Typography
- Layout preferences

### Feature Flags
Enable/disable features in the configuration:
```yaml
features:
  graphql: true
  analytics: true
  streaming: true
  vortex: true
```

### Performance Tuning
Adjust performance settings:
```yaml
vortex:
  batch_size: 1000
  max_concurrent_streams: 4
  cache_enabled: true
```

## Development Workflow

### Adding New Components
1. Use the generator commands
2. Follow Zeropoint naming conventions
3. Include proper documentation
4. Add tests for new functionality

### Customizing Existing Components
1. Extend base classes
2. Override configuration as needed
3. Maintain backward compatibility
4. Update documentation

### Testing
```bash
# Run Zeropoint tests
bundle exec rspec spec/

# Run specific test suites
bundle exec rspec spec/vortex/
bundle exec rspec spec/services/
```

## Support and Documentation

- **GitHub**: [Zeropoint Repository](https://github.com/your-repo/zeropoint)
- **Documentation**: [Zeropoint Docs](https://docs.zeropoint.dev)
- **Issues**: [GitHub Issues](https://github.com/your-repo/zeropoint/issues)

## License

Zeropoint Framework is released under the MIT License. See LICENSE file for details. 