# RuboCop Documentation for Zeropoint Rails App

## Overview

This document describes the RuboCop configuration and usage for the Zeropoint Rails app refactor. RuboCop is used to enforce consistent code style, detect potential issues, and maintain high code quality standards.

## Configuration

### File: `.rubocop.yml`

The main RuboCop configuration file is located at `.rubocop.yml` and includes:

- **Required Extensions**: `rubocop-rails`, `rubocop-rspec`, `rubocop-performance`
- **Target Ruby Version**: 3.3
- **Excluded Directories**: `bin/`, `config/`, `db/`, `vendor/`, `node_modules/`, `tmp/`, `spec/dummy/`, `demo_app/`, `coverage/`, `website/`, `funding/`

### Key Configuration Sections

#### Layout
```yaml
Layout/LineLength:
  Max: 120
  Exclude:
    - 'spec/**/*'

Layout/MultilineMethodCallIndentation:
  EnforcedStyle: indented

Layout/ArrayAlignment:
  EnforcedStyle: with_fixed_indentation

Layout/HashAlignment:
  Enabled: true
```

#### Metrics
```yaml
Metrics/AbcSize:
  Max: 20

Metrics/BlockLength:
  Max: 30
  Exclude:
    - 'spec/**/*'
    - 'config/**/*'

Metrics/ClassLength:
  Max: 200

Metrics/CyclomaticComplexity:
  Max: 10

Metrics/MethodLength:
  Max: 20

Metrics/ModuleLength:
  Max: 200

Metrics/ParameterLists:
  Max: 5
```

#### Style
```yaml
Style/Documentation:
  Enabled: false

Style/FrozenStringLiteralComment:
  Enabled: true
  EnforcedStyle: always

Style/StringLiterals:
  EnforcedStyle: single_quotes

Style/SymbolArray:
  EnforcedStyle: percent
  MinSize: 3

Style/WordArray:
  EnforcedStyle: percent
  MinSize: 3
```

#### Rails
```yaml
Rails/FilePath:
  EnforcedStyle: arguments

Rails/TimeZone:
  EnforcedStyle: strict

Rails/Date:
  EnforcedStyle: strict

Rails/Output:
  Exclude:
    - 'lib/tasks/**/*'
```

#### RSpec
```yaml
RSpec/ExampleLength:
  Max: 20

RSpec/MultipleExpectations:
  Max: 5

RSpec/NestedGroups:
  Max: 4

RSpec/DescribedClass:
  EnforcedStyle: described_class
```

## Usage

### Basic Commands

#### Check All Files
```bash
bundle exec rubocop
```

#### Check Specific Directory
```bash
bundle exec rubocop app/
bundle exec rubocop spec/
bundle exec rubocop lib/
```

#### Check Specific File
```bash
bundle exec rubocop app/controllers/zeropoint/universal_matrix_controller.rb
```

#### Auto-correct Issues
```bash
bundle exec rubocop --autocorrect
bundle exec rubocop --autocorrect app/
```

#### Generate Configuration
```bash
bundle exec rubocop --auto-gen-config
```

### Output Formats

#### Progress Format (Default)
```bash
bundle exec rubocop --format progress
```

#### Simple Format
```bash
bundle exec rubocop --format simple
```

#### JSON Format
```bash
bundle exec rubocop --format json
```

#### HTML Report
```bash
bundle exec rubocop --format html -o rubocop_report.html
```

## Common Issues and Solutions

### 1. Layout/TrailingWhitespace
**Issue**: Trailing whitespace at end of lines
**Solution**: Remove trailing spaces
```ruby
# Bad
def method
end 

# Good
def method
end
```

### 2. Layout/EmptyLineAfterGuardClause
**Issue**: Missing empty line after guard clause
**Solution**: Add empty line after early return
```ruby
# Bad
def method(param)
  return unless param
  do_something
end

# Good
def method(param)
  return unless param

  do_something
end
```

### 3. Style/StringLiterals
**Issue**: Using double quotes for simple strings
**Solution**: Use single quotes when no interpolation needed
```ruby
# Bad
message = "Hello World"

# Good
message = 'Hello World'
```

### 4. Style/TrailingCommaInHashLiteral
**Issue**: Missing trailing comma in multiline hashes
**Solution**: Add trailing comma
```ruby
# Bad
hash = {
  key1: 'value1',
  key2: 'value2'
}

# Good
hash = {
  key1: 'value1',
  key2: 'value2',
}
```

### 5. Style/WordArray
**Issue**: Using array literal for words
**Solution**: Use %w for word arrays
```ruby
# Bad
array = ['one', 'two', 'three']

# Good
array = %w[one two three]
```

### 6. Metrics/MethodLength
**Issue**: Method is too long
**Solution**: Break into smaller methods
```ruby
# Bad
def long_method
  # 20+ lines of code
end

# Good
def long_method
  step_one
  step_two
  step_three
end

private

def step_one
  # 5-7 lines
end
```

## Integration with Development Workflow

### Pre-commit Hooks

Add RuboCop to your pre-commit hooks:

```bash
#!/bin/sh
# .git/hooks/pre-commit

bundle exec rubocop --autocorrect
```

### CI/CD Integration

Add RuboCop to your CI pipeline:

```yaml
# .github/workflows/rubocop.yml
name: RuboCop

on: [push, pull_request]

jobs:
  rubocop:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.3
          bundler-cache: true
      - run: bundle exec rubocop
```

### Editor Integration

#### VS Code
Install the "Ruby" extension and add to settings.json:
```json
{
  "ruby.lint": {
    "rubocop": true
  },
  "ruby.format": "rubocop"
}
```

#### Vim/Neovim
Use ALE or similar plugin:
```vim
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}
```

## Custom Rules for Zeropoint

### Zeropoint-Specific Exclusions

```yaml
AllCops:
  Exclude:
    - 'demo_app/**/*'      # Demo application
    - 'coverage/**/*'      # Test coverage
    - 'website/**/*'       # Static website
    - 'funding/**/*'       # Funding pages
```

### Documentation Style

For Zeropoint, we use YARD-style documentation:

```ruby
# Zeropoint::Vortex
#
# Service for UUID caching, encryption, and stream management.
#
# @example Generate a new vortex UUID
#   Zeropoint::Vortex.generate_uuid
#
module Zeropoint
  class Vortex
    # Generates a new UUID for the vortex system.
    # @return [String] a new UUID
    def self.generate_uuid
      # implementation
    end
  end
end
```

### Naming Conventions

- **Modules**: `Zeropoint::ModuleName`
- **Classes**: `Zeropoint::ClassName`
- **Controllers**: `Zeropoint::ControllerName`
- **Services**: `Zeropoint::ServiceName`
- **Helpers**: `Zeropoint::HelperName`

## Performance Considerations

### RuboCop Performance

- Use `--parallel` for large codebases
- Exclude unnecessary directories
- Use `.rubocop_todo.yml` for gradual fixes

### Code Performance

RuboCop Performance extension checks for:

- `Performance/SelectMap`: Use `map` instead of `select` + `map`
- `Performance/RedundantBlockCall`: Avoid unnecessary block calls
- `Performance/StringReplacement`: Use `tr` instead of `gsub` for single character replacement

## Troubleshooting

### Common Errors

#### "unrecognized cop or department disable found"
**Cause**: Outdated RuboCop configuration
**Solution**: Update `.rubocop.yml` to match current RuboCop version

#### "No such file or directory"
**Cause**: Missing required gems
**Solution**: Run `bundle install`

#### "TargetRubyVersion is not supported"
**Cause**: Ruby version mismatch
**Solution**: Update `TargetRubyVersion` in `.rubocop.yml`

### Debugging

#### Verbose Output
```bash
bundle exec rubocop --debug
```

#### Show Cops
```bash
bundle exec rubocop --show-docs
```

#### List Files
```bash
bundle exec rubocop --list-target-files
```

## Best Practices

### 1. Gradual Adoption
- Use `.rubocop_todo.yml` for existing violations
- Fix issues incrementally
- Don't disable cops without good reason

### 2. Team Consistency
- Agree on configuration with team
- Document custom rules
- Use same configuration across environments

### 3. Regular Maintenance
- Update RuboCop regularly
- Review and update configuration
- Remove obsolete exclusions

### 4. Documentation
- Document custom rules
- Explain complex configurations
- Keep this documentation updated

## Resources

- [RuboCop Documentation](https://docs.rubocop.org/)
- [RuboCop Rails](https://github.com/rubocop/rubocop-rails)
- [RuboCop RSpec](https://github.com/rubocop/rubocop-rspec)
- [RuboCop Performance](https://github.com/rubocop/rubocop-performance)
- [Style Guide](https://rubystyle.guide/)

## Contributing

When contributing to Zeropoint:

1. Run RuboCop before submitting PRs
2. Fix all auto-correctable issues
3. Document any new custom rules
4. Update this documentation if needed

## CI/CD Integration: GitHub Actions

A ready-to-use GitHub Actions workflow for RuboCop is provided at `.github/workflows/rubocop.yml`:

```yaml
name: RuboCop

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  rubocop:
    name: RuboCop Lint
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.3
          bundler-cache: true
      - name: Install dependencies
        run: bundle install --jobs 4 --retry 3
      - name: Run RuboCop
        run: bundle exec rubocop --format progress
```

This workflow will automatically lint your code on every push and pull request to `main` or `master` branches. If any RuboCop offenses are found, the workflow will fail, helping you maintain code quality.

## RuboDevelop: Custom Cop Development

You can extend RuboCop for Zeropoint by developing custom cops (rules) to enforce project-specific standards.

### Steps to Develop a Custom Cop

1. **Create a directory for custom cops:**
   - `lib/rubocop/cop/zeropoint/`
2. **Write your custom cop:**
   - Example: `lib/rubocop/cop/zeropoint/require_yard_doc.rb`

```ruby
# frozen_string_literal: true

module RuboCop
  module Cop
    module Zeropoint
      class RequireYardDoc < Cop
        MSG = 'All public methods must have YARD doc comments.'

        def on_def(node)
          return if processed_source.comments.any? do |comment|
            comment.loc.line == node.first_line - 1 && comment.text.include?('@return')
          end

          add_offense(node, message: MSG)
        end
      end
    end
  end
end
```

3. **Register your cop in `.rubocop.yml`:**
```yaml
require:
  - ./lib/rubocop/cop/zeropoint/require_yard_doc.rb

Zeropoint/RequireYardDoc:
  Enabled: true
```

4. **Run RuboCop as usual:**
```bash
bundle exec rubocop
```

### Tips for Custom Cop Development
- Use the [RuboCop Extension API](https://docs.rubocop.org/rubocop/development.html) for advanced cops.
- Write specs for your custom cops using `rspec`.
- Document your custom cops in this file and in your codebase.

## Resources

- [RuboCop Documentation](https://docs.rubocop.org/)
- [RuboCop Rails](https://github.com/rubocop/rubocop-rails)
- [RuboCop RSpec](https://github.com/rubocop/rubocop-rspec)
- [RuboCop Performance](https://github.com/rubocop/rubocop-performance)
- [Style Guide](https://rubystyle.guide/)
- [RuboCop Custom Cops Guide](https://docs.rubocop.org/rubocop/development.html) 

## Development Loop

This documentation is automatically updated by the RuboCop Development Loop.
The loop runs until the error vortex is void (no more offenses found).

### Current Status
- **Iteration**: 1
- **Last Run**: 2025-06-28 06:33:34 +0300
- **Status**: Running

### Development Loop Configuration
```ruby
CONFIG = {
  max_iterations: 10,
  documentation_file: 'docs/RUBOCOP_DOCUMENTATION.md',
  config_file: '.rubocop.yml',
  todo_file: '.rubocop_todo.yml',
  log_file: 'rubocop_development.log'
}
```

### How to Run
```ruby
# Run the development loop
RuboCop::DevelopmentLoop.run
```

### Iteration History
No iterations recorded yet.