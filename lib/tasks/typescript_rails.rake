# frozen_string_literal: true

# TypeScript Rails Rake Tasks
# Provides Rake tasks for TypeScript integration

namespace :typescript_rails do
  desc 'Install TypeScript Rails components'
  task install: :environment do
    puts 'Installing TypeScript Rails components...'

    # Create directories
    FileUtils.mkdir_p('app/javascript/components')
    FileUtils.mkdir_p('app/javascript/hooks')
    FileUtils.mkdir_p('app/javascript/utils')

    # Copy base files
    copy_base_files

    puts 'TypeScript Rails installation complete!'
  end

  desc 'Generate component'
  task :component, [ :name ] => :environment do |_task, args|
    name = args[:name]
    raise 'Component name required' unless name

    generate_component(name)
  end

  desc 'Generate hook'
  task :hook, [ :name ] => :environment do |_task, args|
    name = args[:name]
    raise 'Hook name required' unless name

    generate_hook(name)
  end

  desc 'Generate TypeScript type definitions from Rails configuration'
  task generate_types: :environment do
    puts 'Generating TypeScript type definitions...'
    TypeScriptRails.generate_types
    puts 'TypeScript type definitions generated successfully!'
  end

  desc 'Install TypeScript dependencies'
  task install_dependencies: :environment do
    puts 'Installing TypeScript dependencies...'

    # Check if package.json exists
    unless File.exist?('package.json')
      puts 'Creating package.json...'
      system('npm init -y')
    end

    # Install TypeScript dependencies
    dependencies = [
      'typescript',
      '@types/react',
      '@types/react-dom',
      'react',
      'react-dom',
      '@graphql-ui-layout/api-client',
    ]

    dependencies.each do |dep|
      puts "Installing #{dep}..."
      system("npm install #{dep}")
    end

    puts 'TypeScript dependencies installed successfully!'
  end

  desc 'Build TypeScript files'
  task build: :environment do
    puts 'Building TypeScript files...'

    if File.exist?('typescript.config.js')
      system('npx tsc --project typescript.config.js')
    elsif File.exist?('tsconfig.json')
      system('npx tsc')
    else
      puts 'No TypeScript configuration found. Please run: rails typescript_rails:install'
    end
  end

  desc 'Watch TypeScript files for changes'
  task watch: :environment do
    puts 'Watching TypeScript files for changes...'

    if File.exist?('typescript.config.js')
      system('npx tsc --project typescript.config.js --watch')
    elsif File.exist?('tsconfig.json')
      system('npx tsc --watch')
    else
      puts 'No TypeScript configuration found. Please run: rails typescript_rails:install'
    end
  end

  desc 'Clean TypeScript build files'
  task clean: :environment do
    puts 'Cleaning TypeScript build files...'

    build_dirs = [ 'dist', 'app/javascript/dist', 'tmp/typescript' ]
    build_dirs.each do |dir|
      if Dir.exist?(dir)
        FileUtils.rm_rf(dir)
        puts "Removed #{dir}"
      end
    end

    puts 'TypeScript build files cleaned successfully!'
  end

  desc 'Run TypeScript type checking'
  task type_check: :environment do
    puts 'Running TypeScript type checking...'

    if File.exist?('typescript.config.js')
      system('npx tsc --project typescript.config.js --noEmit')
    elsif File.exist?('tsconfig.json')
      system('npx tsc --noEmit')
    else
      puts 'No TypeScript configuration found. Please run: rails typescript_rails:install'
    end
  end

  desc 'Run TypeScript tests'
  task test: :environment do
    puts 'Running TypeScript tests...'

    if File.exist?('package.json')
      system('npm test')
    else
      puts 'No package.json found. Please run: rails typescript_rails:install'
    end
  end

  desc 'Lint TypeScript files'
  task lint: :environment do
    puts 'Linting TypeScript files...'

    if File.exist?('package.json')
      system('npm run lint')
    else
      puts 'No package.json found. Please run: rails typescript_rails:install'
    end
  end

  desc 'Format TypeScript files'
  task format: :environment do
    puts 'Formatting TypeScript files...'

    if File.exist?('package.json')
      system('npm run format')
    else
      puts 'No package.json found. Please run: rails typescript_rails:install'
    end
  end

  desc 'Setup complete TypeScript Rails integration'
  task setup: :environment do
    puts 'Setting up TypeScript Rails integration...'

    # Run all setup tasks
    Rake::Task['typescript_rails:install_dependencies'].invoke
    Rake::Task['typescript_rails:generate_types'].invoke
    Rake::Task['typescript_rails:build'].invoke

    puts 'TypeScript Rails integration setup complete!'
  end

  desc 'Update TypeScript configuration from Rails'
  task update_config: :environment do
    puts 'Updating TypeScript configuration from Rails...'

    # Generate new type definitions
    TypeScriptRails.generate_types

    # Update API configuration
    config = TypeScriptRails.api_config
    config_file = Rails.root.join('app/javascript/types/rails-config.ts')

    if File.exist?(config_file)
      content = File.read(config_file)
      updated_content = content.gsub(
        /export const railsConfig: RailsConfig = \{.*?\};/m,
        "export const railsConfig: RailsConfig = #{JSON.pretty_generate(config)};",
      )
      File.write(config_file, updated_content)
      puts 'TypeScript configuration updated successfully!'
    else
      puts 'Configuration file not found. Please run: rails typescript_rails:install'
    end
  end

  desc 'Validate TypeScript Rails integration'
  task validate: :environment do
    puts 'Validating TypeScript Rails integration...'

    errors = []

    # Check required files
    required_files = [
      'package.json',
      'tsconfig.json',
      'app/javascript/types/rails-config.ts',
    ]

    required_files.each do |file|
      errors << "Missing required file: #{file}" unless File.exist?(file)
    end

    # Check TypeScript compilation
    begin
      Rake::Task['typescript_rails:type_check'].invoke
    rescue StandardError => e
      errors << "TypeScript compilation failed: #{e.message}"
    end

    # Check Rails integration
    errors << 'TypeScriptRails module not loaded' unless defined?(TypeScriptRails)

    if errors.empty?
      puts 'TypeScript Rails integration is valid!'
    else
      puts 'Validation failed:'
      errors.each { |error| puts "  - #{error}" }
      exit 1
    end
  end

  desc 'Show TypeScript Rails status'
  task status: :environment do
    puts 'TypeScript Rails Integration Status'
    puts '=' * 40

    # Check configuration
    puts "\nConfiguration:"
    puts "  API Base URL: #{TypeScriptRails.configuration.api_base_url}"
    puts "  API Version: #{TypeScriptRails.configuration.api_version}"
    puts "  Timeout: #{TypeScriptRails.configuration.default_timeout}ms"
    puts "  Offline Support: #{TypeScriptRails.configuration.enable_offline_support}"
    puts "  Auto Refresh: #{TypeScriptRails.configuration.auto_refresh}"

    # Check files
    puts "\nFiles:"
    files = [
      'package.json',
      'tsconfig.json',
      'app/javascript/types/rails-config.ts',
      'app/javascript/services/api-client.ts',
    ]

    files.each do |file|
      status = File.exist?(file) ? '✓' : '✗'
      puts "  #{status} #{file}"
    end

    # Check TypeScript compilation
    puts "\nTypeScript Compilation:"
    begin
      Rake::Task['typescript_rails:type_check'].invoke
      puts '  ✓ TypeScript compilation successful'
    rescue StandardError => e
      puts "  ✗ TypeScript compilation failed: #{e.message}"
    end

    puts "\nFor more information, run: rails typescript_rails:help"
  end

  desc 'Show TypeScript Rails help'
  task help: :environment do
    puts 'TypeScript Rails Integration Help'
    puts '=' * 40
    puts "\nAvailable tasks:"
    puts '  rails typescript_rails:install          - Install TypeScript integration'
    puts '  rails typescript_rails:setup            - Complete setup'
    puts '  rails typescript_rails:generate_types   - Generate type definitions'
    puts '  rails typescript_rails:build            - Build TypeScript files'
    puts '  rails typescript_rails:watch            - Watch for changes'
    puts '  rails typescript_rails:clean            - Clean build files'
    puts '  rails typescript_rails:type_check       - Type checking'
    puts '  rails typescript_rails:test             - Run tests'
    puts '  rails typescript_rails:lint             - Lint files'
    puts '  rails typescript_rails:format           - Format files'
    puts '  rails typescript_rails:update_config    - Update configuration'
    puts '  rails typescript_rails:validate         - Validate integration'
    puts '  rails typescript_rails:status           - Show status'
    puts '  rails typescript_rails:help             - Show this help'
    puts "\nGenerators:"
    puts '  rails generate typescript_rails:component ComponentName prop1:type prop2:type'
    puts '  rails generate typescript_rails:hook HookName dep1:type dep2:type'
    puts "\nFor more information, see the documentation at:"
    puts 'https://github.com/your-org/graphql-ui-layout#typescript-integration'
  end

  private

  def copy_base_files
    # Copy TypeScript configuration
    File.write('tsconfig.json', default_tsconfig) unless File.exist?('tsconfig.json')

    # Copy package.json if needed
    File.write('package.json', default_package_json) unless File.exist?('package.json')
  end

  def generate_component(name)
    component_dir = "app/javascript/components/#{name.underscore}"
    FileUtils.mkdir_p(component_dir)

    component_content = <<~TSX
      import React from 'react';

      interface #{name.camelize}Props {
        // Add your props here
      }

      export const #{name.camelize}: React.FC<#{name.camelize}Props> = (props) => {
        return (
          <div className="#{name.underscore}">
            {/* Your component content */}
          </div>
        );
      };
    TSX

    File.write("#{component_dir}/index.tsx", component_content)
    puts "Generated component: #{component_dir}/index.tsx"
  end

  def generate_hook(name)
    hook_content = <<~TS
      import { useState, useEffect } from 'react';

      export const use#{name.camelize} = () => {
        const [state, setState] = useState(null);
      #{'  '}
        useEffect(() => {
          // Your hook logic here
        }, []);
      #{'  '}
        return { state };
      };
    TS

    File.write("app/javascript/hooks/use#{name.camelize}.ts", hook_content)
    puts "Generated hook: app/javascript/hooks/use#{name.camelize}.ts"
  end

  def default_tsconfig
    <<~JSON
      {
        "compilerOptions": {
          "target": "ES2020",
          "lib": ["dom", "dom.iterable", "es6"],
          "allowJs": true,
          "skipLibCheck": true,
          "esModuleInterop": true,
          "allowSyntheticDefaultImports": true,
          "strict": true,
          "forceConsistentCasingInFileNames": true,
          "noFallthroughCasesInSwitch": true,
          "module": "esnext",
          "moduleResolution": "node",
          "resolveJsonModule": true,
          "isolatedModules": true,
          "noEmit": true,
          "jsx": "react-jsx"
        },
        "include": ["app/javascript/**/*"]
      }
    JSON
  end

  def default_package_json
    <<~JSON
      {
        "name": "typescript-rails-app",
        "version": "1.0.0",
        "dependencies": {
          "react": "^18.0.0",
          "react-dom": "^18.0.0"
        },
        "devDependencies": {
          "@types/react": "^18.0.0",
          "@types/react-dom": "^18.0.0",
          "typescript": "^4.9.0"
        }
      }
    JSON
  end
end
