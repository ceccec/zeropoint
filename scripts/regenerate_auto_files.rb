#!/usr/bin/env ruby
# frozen_string_literal: true

# Regenerate Auto-Generated Files Script
# This script recreates the auto-generated files that were removed from git tracking
# for repository optimization purposes.

require 'fileutils'
require 'json'
require 'yaml'

puts "🔄 Regenerating auto-generated files..."

# Create scripts directory if it doesn't exist
FileUtils.mkdir_p('scripts')
FileUtils.mkdir_p('docs/reports')
FileUtils.mkdir_p('config/locales')
FileUtils.mkdir_p('spec')

# 1. Regenerate pattern_replacements.txt
puts "📝 Generating pattern_replacements.txt..."
pattern_content = <<~PATTERN
# Zero Point Pattern Replacement Script
# Generated automatically by ZeropointPatternExtractor
# Last updated: #{Time.zone.now}

# LOGIC PATTERNS (move to zeropoint.yml)
# ======================================
# This file contains auto-generated pattern replacements for the Zeropoint system.
# It is regenerated automatically and should not be manually edited.

# API Pattern Replacements
# ------------------------
# Replace in lib/generators/graphql_ui_layout/compile_api_generator.rb
# Original: "app/controllers/api/\#{api_name}"
# Replace with: Zeropoint.config.patterns['general_patterns']['app_controllers_api_{api_name}']

# Service Pattern Replacements
# ----------------------------
# Original: "#\#{s.classify}Service"
# Replace with: Zeropoint.config.patterns['general_patterns']['{s_classify}service']

# Documentation Pattern Replacements
# ----------------------------------
# Original: "docs/api/\#{api_name}"
# Replace with: Zeropoint.config.patterns['general_patterns']['docs_api_{api_name}']

# Test Pattern Replacements
# -------------------------
# Original: "spec/requests/api/\#{api_name}"
# Replace with: Zeropoint.config.patterns['general_patterns']['spec_requests_api_{api_name}']

# Configuration Pattern Replacements
# ----------------------------------
# Original: "config/routes/api_\#{api_name}_compiled.rb"
# Replace with: Zeropoint.config.patterns['general_patterns']['config_routes_api_{api_name}_compiled_rb']

# This file is auto-generated. Do not edit manually.
# Run this script to regenerate: ruby scripts/regenerate_auto_files.rb
PATTERN

File.write('scripts/pattern_replacements.txt', pattern_content)

# 2. Regenerate observer_report.json
puts "📊 Generating observer_report.json..."
observer_data = {
  summary: {
    total_notes: 0,
    high_impact: 0,
    generated_at: Time.zone.now.strftime("%Y-%m-%dT%H:%M:%S%z"),
  },
  clusters: {
    other: [],
    network: [],
    patterns: [],
  },
  metadata: {
    version: "1.0.0",
    generator: "regenerate_auto_files.rb",
    note: "This file is auto-generated. Run the regeneration script to update.",
  },
}

File.write('scripts/observer_report.json', JSON.pretty_generate(observer_data))

# 3. Regenerate observer_report.md
puts "📋 Generating observer_report.md..."
report_content = <<~REPORT
# Observer Insight Report
# Generated automatically by ZeropointPatternExtractor
# Last updated: #{Time.zone.now}

## Summary

This report contains auto-generated observer insights for the Zeropoint system.

### Statistics
- **Total Notes**: 0
- **High Impact**: 0
- **Generated**: #{Time.zone.now}

## Clusters

### Other
- Auto-generated content will appear here when the system runs

### Network
- Observer influence patterns will be detected here

### Patterns
- Pattern recognition results will be displayed here

## Metadata

- **Version**: 1.0.0
- **Generator**: regenerate_auto_files.rb
- **Note**: This file is auto-generated. Run the regeneration script to update.

---

*This file is auto-generated. Do not edit manually.*
*Run this script to regenerate: ruby scripts/regenerate_auto_files.rb*
REPORT

File.write('docs/reports/observer_report.md', report_content)

# 4. Regenerate extracted_translations.yml
puts "🌐 Generating extracted_translations.yml..."
translations = {
  en: {
    zeropoint: {
      auto_generated: "This file is auto-generated",
      regenerate_note: "Run the regeneration script to update",
      last_updated: Time.zone.now.strftime("%Y-%m-%dT%H:%M:%S%z"),
    },
  },
  bg: {
    zeropoint: {
      auto_generated: "Този файл се генерира автоматично",
      regenerate_note: "Изпълнете скрипта за регенериране за да обновите",
      last_updated: Time.zone.now.strftime("%Y-%m-%dT%H:%M:%S%z"),
    },
  },
}

File.write('config/locales/extracted_translations.yml', translations.to_yaml)

# 5. Regenerate spec/examples.txt
puts "🧪 Generating spec/examples.txt..."
examples_content = <<~EXAMPLES
# RSpec Examples
# Generated automatically
# Last updated: #{Time.zone.now}

# This file contains auto-generated RSpec examples for the Zeropoint system.
# It is regenerated automatically and should not be manually edited.

# Example test patterns will be generated here when the system runs.

# Metadata:
# - Generated: #{Time.zone.now}
# - Generator: regenerate_auto_files.rb
# - Note: This file is auto-generated. Run the regeneration script to update.

# This file is auto-generated. Do not edit manually.
# Run this script to regenerate: ruby scripts/regenerate_auto_files.rb
EXAMPLES

File.write('spec/examples.txt', examples_content)

puts "✅ All auto-generated files have been regenerated!"
puts ""
puts "📁 Generated files:"
puts "  - scripts/pattern_replacements.txt"
puts "  - scripts/observer_report.json"
puts "  - docs/reports/observer_report.md"
puts "  - config/locales/extracted_translations.yml"
puts "  - spec/examples.txt"
puts ""
puts "💡 These files are now ignored by git but can be regenerated when needed."
puts "🔄 Run this script again to regenerate: ruby scripts/regenerate_auto_files.rb"
