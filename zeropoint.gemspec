# frozen_string_literal: true

require_relative 'lib/zeropoint/version'

Gem::Specification.new do |spec|
  spec.name = 'zeropoint'
  spec.version = Zeropoint::VERSION
  spec.authors = [ 'Zeropoint Team' ]
  spec.email = [ 'team@zeropoint.bg' ]

  spec.summary = 'A consciousness-aware Rails framework with GraphQL-first architecture and vortex mathematics'
  spec.description = <<~DESC
    Zeropoint is a revolutionary Rails framework that integrates consciousness physics,#{' '}
    vortex mathematics, and quantum principles to create a unified, scalable, and#{' '}
    self-evolving platform. Features include:

    🌌 Consciousness-aware error handling and golden ratio optimization
    🔄 Vortex mathematics for optimal data flow and infinite scalability
    🎯 GraphQL-first API with batch loading and query persistence
    🌍 Internationalization with cosmic harmony principles
    🧠 Self-evolving intelligence system with pattern recognition
    🔒 Quantum security with observer-aware encryption
    ⚡ High-performance caching with vortex streaming
    🎨 Unified UI/UX with consciousness-aware design patterns
  DESC

  spec.homepage = 'https://zeropoint.bg'
  spec.license = 'Zeropoint'
  spec.required_ruby_version = '>= 3.0.0'
  spec.required_rubygems_version = '>= 3.0.0'

  # Metadata for gem discovery and documentation
  spec.metadata = {
    homepage_uri: spec.homepage,
    source_code_uri: 'https://github.com/zeropoint/zeropoint',
    changelog_uri: 'https://github.com/zeropoint/zeropoint/blob/main/CHANGELOG.md',
    bug_tracker_uri: 'https://github.com/zeropoint/zeropoint/issues',
    documentation_uri: 'https://zeropoint.bg/docs',
    wiki_uri: 'https://github.com/zeropoint/zeropoint/wiki',
    rubygems_mfa_required: 'true',
    funding_uri: 'https://github.com/sponsors/zeropoint',
    allowed_push_host: 'https://rubygems.org',
  }

  # Specify which files should be added to the gem when it is released
  spec.files = Dir.glob('lib/**/*') + Dir.glob('app/**/*') + Dir.glob('config/**/*') + %w[
    README.md
    CHANGELOG.md
    LICENSE.txt
    zeropoint.gemspec
    .ruby-version
    .rubocop.yml
    .reek.yml
  ]

  spec.require_paths = [ 'lib' ]
  spec.bindir = 'bin'
  spec.executables = [ 'zeropoint' ]

  # Core Rails dependencies
  spec.add_dependency 'rails', '>= 7.0', '< 9.0'
  spec.add_dependency 'activesupport', '>= 7.0', '< 9.0'
  spec.add_dependency 'activerecord', '>= 7.0', '< 9.0'
  spec.add_dependency 'actionpack', '>= 7.0', '< 9.0'

  # GraphQL ecosystem
  spec.add_dependency 'graphql', '~> 2.0'
  spec.add_dependency 'graphql-batch', '~> 0.6'
  spec.add_dependency 'graphql-persisted_queries', '>= 1', '< 3'
  spec.add_dependency 'graphql-fragment_cache', '~> 1.0'

  # Concurrency and performance
  spec.add_dependency 'concurrent-ruby', '~> 1.2'
  spec.add_dependency 'redis', '~> 5.0'
  spec.add_dependency 'connection_pool', '~> 2.4'

  # Data processing and validation
  spec.add_dependency 'dry-monads', '~> 1.6'
  spec.add_dependency 'dry-validation', '~> 1.10'
  spec.add_dependency 'dry-transaction', '~> 0.15'
  spec.add_dependency 'dry-configurable', '~> 1.0'

  # Internationalization
  spec.add_dependency 'i18n', '>= 1.0'
  spec.add_dependency 'fast_gettext', '~> 2.0'
  spec.add_dependency 'globalize', '~> 7.0'

  # Security and encryption
  spec.add_dependency 'lockbox', '~> 1.0'
  spec.add_dependency 'blind_index', '~> 2.0'
  spec.add_dependency 'strong_password', '~> 0.0.10'

  # Background processing
  spec.add_dependency 'sidekiq', '~> 7.0'
  spec.add_dependency 'sidekiq-scheduler', '~> 5.0'

  # Monitoring and observability
  spec.add_dependency 'lograge', '~> 0.12'
  spec.add_dependency 'sentry-ruby', '~> 5.0'
  spec.add_dependency 'bullet', '~> 7.0'

  # Development dependencies
  spec.add_development_dependency 'rspec-rails', '~> 7.0'
  spec.add_development_dependency 'factory_bot_rails', '~> 6.0'
  spec.add_development_dependency 'faker', '~> 3.0'
  spec.add_development_dependency 'capybara', '~> 3.38'
  spec.add_development_dependency 'selenium-webdriver', '~> 4.8'
  spec.add_development_dependency 'webdrivers', '~> 5.0'

  # Code quality and linting
  spec.add_development_dependency 'rubocop', '~> 1.75'
  spec.add_development_dependency 'rubocop-rails', '~> 2.20'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.20'
  spec.add_development_dependency 'rubocop-performance', '~> 1.0'
  spec.add_development_dependency 'reek', '~> 6.0'
  spec.add_development_dependency 'brakeman', '~> 5.4'
  spec.add_development_dependency 'bundler-audit', '~> 0.9'

  # Testing and coverage
  spec.add_development_dependency 'simplecov', '~> 0.22'
  spec.add_development_dependency 'simplecov-console', '~> 0.9'
  spec.add_development_dependency 'database_cleaner-active_record', '~> 2.0'
  spec.add_development_dependency 'timecop', '~> 0.9'

  # Performance and benchmarking
  spec.add_development_dependency 'benchmark-ips', '~> 2.0'
  spec.add_development_dependency 'memory_profiler', '~> 1.0'
  spec.add_development_dependency 'stackprof', '~> 0.2'
  spec.add_development_dependency 'derailed_benchmarks', '~> 2.0'

  # Documentation
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'redcarpet', '~> 3.5'
  spec.add_development_dependency 'github-markup', '~> 4.0'

  # Development tools
  spec.add_development_dependency 'pry-byebug', '~> 3.10'
  spec.add_development_dependency 'pry-rails', '~> 0.3'
  spec.add_development_dependency 'awesome_print', '~> 1.9'
  spec.add_development_dependency 'annotate', '~> 3.2'
  spec.add_development_dependency 'bullet', '~> 7.0'
  spec.add_development_dependency 'letter_opener', '~> 1.8'
  spec.add_development_dependency 'better_errors', '~> 2.10'
  spec.add_development_dependency 'binding_of_caller', '~> 1.0'
end
