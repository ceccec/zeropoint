#!/usr/bin/env ruby
# frozen_string_literal: true

# Zero Point Pattern Extractor
# Extracts application logic patterns and organizes them into zeropoint.yml
# Keeps pure translations in locale files

require 'fileutils'
require 'yaml'
require 'json'

class ZeropointPatternExtractor
  def initialize
    @logic_patterns = {}
    @pure_translations = {}
    @pattern_occurrences = {}
    @translation_occurrences = {}
  end

  def extract_from_directory(directory)
    puts "📁 Scanning #{directory}..."
    Dir.glob("#{directory}/**/*.rb").each do |file|
      next if file.include?('spec/') || file.include?('test/') || file.include?('scripts/')
      extract_from_file(file)
    end
  end

  def extract_from_file(file_path)
    content = File.read(file_path)
    lines = content.lines

    lines.each_with_index do |line, index|
      extract_patterns(line, file_path, index + 1)
      extract_translations(line, file_path, index + 1)
    end
  end

  def extract_patterns(line, file_path, line_number)
    # Logic pattern indicators
    patterns = [
      # Error messages with interpolation
      /"[^"]*%\{[^}]*\}[^"]*"/,
      # Raise statements with interpolation
      /raise\s+[^,]+,\s+"([^"]*%\{[^}]*\}[^"]*)"/,
      # Log messages with interpolation
      /Rails\.logger\.[^"]*"([^"]*%\{[^}]*\}[^"]*)"/,
      # Zeropoint logger with interpolation
      /Zeropoint\.logger\.[^"]*"([^"]*%\{[^}]*\}[^"]*)"/,
      # Puts statements with interpolation
      /puts\s+"([^"]*%\{[^}]*\}[^"]*)"/,
      # String interpolation patterns
      /"[^"]*#\{[^}]*\}[^"]*"/,
      # Template-like strings
      /"[^"]*\{[^}]*\}[^"]*"/,
    ]

    patterns.each do |pattern|
      line.scan(pattern).flatten.each do |match|
        next if match.length < 5 || match.length > 200
        next if match.match?(/^[A-Z_]+$/) # Skip constants

        add_logic_pattern(match, file_path, line_number)
      end
    end
  end

  def extract_translations(line, file_path, line_number)
    # Pure translation indicators (no interpolation)
    patterns = [
      # Simple capitalized strings
      /"[A-Z][^"]*[a-z][^"]*"/,
      # Single quoted capitalized strings
      /'[A-Z][^']*[a-z][^']*'/,
      # Simple puts statements
      /puts\s+"([^"]*[A-Z][^"]*[a-z][^"]*)"/,
      # Simple raise statements
      /raise\s+[^,]+,\s+"([^"]*[A-Z][^"]*[a-z][^"]*)"/,
    ]

    patterns.each do |pattern|
      line.scan(pattern).flatten.each do |match|
        next if match.length < 3 || match.length > 100
        next if match.match?(/^[A-Z_]+$/) # Skip constants
        next if match.match?(/%\{[^}]*\}/) # Skip interpolation

        add_pure_translation(match, file_path, line_number)
      end
    end
  end

  def add_logic_pattern(text, file_path, line_number)
    key = generate_pattern_key(text)
    @logic_patterns[key] ||= {
      text: text,
      occurrences: [],
      category: determine_pattern_category(text),
    }
    @logic_patterns[key][:occurrences] << {
      file: file_path,
      line: line_number,
    }
  end

  def add_pure_translation(text, file_path, line_number)
    key = generate_translation_key(text)
    @pure_translations[key] ||= {
      text: text,
      occurrences: [],
      category: determine_translation_category(text),
    }
    @pure_translations[key][:occurrences] << {
      file: file_path,
      line: line_number,
    }
  end

  def generate_pattern_key(text)
    # Convert to a valid YAML key for logic patterns
    key = text.downcase
              .gsub(/[^a-z0-9\s%{}]/, ' ')
              .gsub(/\s+/, '_')
              .gsub(/%\{[^}]*\}/, 'placeholder')
              .strip
              .gsub(/^_+|_+$/, '')

    # Ensure uniqueness
    base_key = key
    counter = 1
    while @logic_patterns.key?(key)
      key = "#{base_key}_#{counter}"
      counter += 1
    end

    key
  end

  def generate_translation_key(text)
    # Convert to a valid YAML key for translations
    key = text.downcase
              .gsub(/[^a-z0-9\s]/, ' ')
              .gsub(/\s+/, '_')
              .strip
              .gsub(/^_+|_+$/, '')

    # Ensure uniqueness
    base_key = key
    counter = 1
    while @pure_translations.key?(key)
      key = "#{base_key}_#{counter}"
      counter += 1
    end

    key
  end

  def determine_pattern_category(text)
    if text.match?(/error|failed|invalid|not found|missing/i)
      'errors'
    elsif text.match?(/success|cleared|updated|created|warmed/i)
      'api_responses'
    elsif text.match?(/demo|example|sample/i)
      'demo_messages'
    elsif text.match?(/log|debug|info|warn/i)
      'logging'
    elsif text.match?(/vortex|stream|flow/i)
      'vortex_logic'
    elsif text.match?(/golden|ratio|compliance/i)
      'golden_ratio'
    elsif text.match?(/search|model|engine/i)
      'search_logic'
    elsif text.match?(/cache|key|warmed/i)
      'cache_logic'
    else
      'general_patterns'
    end
  end

  def determine_translation_category(text)
    if text.match?(/home|login|register|dashboard|admin/i)
      'navigation'
    elsif text.match?(/error|failed|invalid/i)
      'errors'
    elsif text.match?(/success|cleared|updated/i)
      'api'
    elsif text.match?(/demo|example|sample/i)
      'demo'
    elsif text.match?(/vortex|stream|flow/i)
      'vortex'
    elsif text.match?(/golden|ratio/i)
      'golden_ratio'
    else
      'general'
    end
  end

  def generate_zeropoint_yml
    yaml_content = { zeropoint: { patterns: {} } }

    @logic_patterns.each do |key, data|
      category = data[:category]
      yaml_content['zeropoint']['patterns'][category] ||= {}
      yaml_content['zeropoint']['patterns'][category][key] = data[:text]
    end

    yaml_content
  end

  def generate_translations_yml
    yaml_content = { en: { zeropoint: {} } }

    @pure_translations.each do |key, data|
      category = data[:category]
      yaml_content['en']['zeropoint'][category] ||= {}
      yaml_content['en']['zeropoint'][category][key] = data[:text]
    end

    yaml_content
  end

  def generate_replacement_script
    script = []
    script << "# Zero Point Pattern Replacement Script"
    script << "# Generated automatically by ZeropointPatternExtractor"
    script << ""

    script << "# LOGIC PATTERNS (move to zeropoint.yml)"
    script << "# ======================================"
    @logic_patterns.each do |key, data|
      data[:occurrences].each do |occurrence|
        script << "# Replace in #{occurrence[:file]}:#{occurrence[:line]}"
        script << "# Original: #{data[:text]}"
        script << "# Replace with: Rails.application.config_for(:zeropoint)['patterns']['#{data[:category]}']['#{key}']"
        script << "# Or: Zeropoint.config.patterns['#{data[:category]}']['#{key}']"
        script << ""
      end
    end

    script << "# PURE TRANSLATIONS (keep in locale files)"
    script << "# ========================================"
    @pure_translations.each do |key, data|
      data[:occurrences].each do |occurrence|
        script << "# Replace in #{occurrence[:file]}:#{occurrence[:line]}"
        script << "# Original: #{data[:text]}"
        script << "# Replace with: I18n.t('zeropoint.#{data[:category]}.#{key}')"
        script << ""
      end
    end

    script.join("\n")
  end

  def save_zeropoint_yml(file_path)
    yaml_content = generate_zeropoint_yml
    File.write(file_path, yaml_content.to_yaml)
    puts "✅ Generated zeropoint.yml: #{file_path}"
  end

  def save_translations_yml(file_path)
    yaml_content = generate_translations_yml
    File.write(file_path, yaml_content.to_yaml)
    puts "✅ Generated translations YAML: #{file_path}"
  end

  def save_replacement_script(file_path)
    script_content = generate_replacement_script
    File.write(file_path, script_content)
    puts "✅ Generated replacement script: #{file_path}"
  end

  def print_summary
    puts "\n🌌 Zero Point Pattern Extraction Summary"
    puts "=" * 60

    puts "\n📊 LOGIC PATTERNS (for zeropoint.yml):"
    puts "Total patterns found: #{@logic_patterns.size}"
    @logic_patterns.each do |key, data|
      puts "\n🔧 Pattern: #{key}"
      puts "   Text: #{data[:text]}"
      puts "   Category: #{data[:category]}"
      puts "   Occurrences: #{data[:occurrences].size}"
      data[:occurrences].each do |occurrence|
        puts "     - #{occurrence[:file]}:#{occurrence[:line]}"
      end
    end

    puts "\n📊 PURE TRANSLATIONS (for locale files):"
    puts "Total translations found: #{@pure_translations.size}"
    @pure_translations.each do |key, data|
      puts "\n🌐 Translation: #{key}"
      puts "   Text: #{data[:text]}"
      puts "   Category: #{data[:category]}"
      puts "   Occurrences: #{data[:occurrences].size}"
      data[:occurrences].each do |occurrence|
        puts "     - #{occurrence[:file]}:#{occurrence[:line]}"
      end
    end
  end

  def find_duplicates
    puts "\n🔍 DUPLICATE ANALYSIS"
    puts "=" * 30

    # Find duplicate logic patterns
    pattern_texts = @logic_patterns.values.map { |data| data[:text] }
    duplicate_patterns = pattern_texts.group_by { |text| text }.select { |_, group| group.size > 1 }

    if duplicate_patterns.any?
      puts "\n⚠️  Duplicate Logic Patterns:"
      duplicate_patterns.each do |text, _|
        puts "   Text: #{text}"
        @logic_patterns.each do |key, data|
          if data[:text] == text
            puts "     - Key: #{key} (Category: #{data[:category]})"
          end
        end
        puts ""
      end
    else
      puts "✅ No duplicate logic patterns found"
    end

    # Find duplicate translations
    translation_texts = @pure_translations.values.map { |data| data[:text] }
    duplicate_translations = translation_texts.group_by { |text| text }.select { |_, group| group.size > 1 }

    if duplicate_translations.any?
      puts "\n⚠️  Duplicate Translations:"
      duplicate_translations.each do |text, _|
        puts "   Text: #{text}"
        @pure_translations.each do |key, data|
          if data[:text] == text
            puts "     - Key: #{key} (Category: #{data[:category]})"
          end
        end
        puts ""
      end
    else
      puts "✅ No duplicate translations found"
    end
  end
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  extractor = ZeropointPatternExtractor.new

  puts "🌌 Zero Point Pattern Extractor"
  puts "=" * 40

  # Extract from lib directory
  puts "📁 Extracting from lib/..."
  extractor.extract_from_directory('lib')

  # Extract from demo_app directory
  puts "📁 Extracting from demo_app/..."
  extractor.extract_from_directory('demo_app')

  # Extract from examples directory
  puts "📁 Extracting from examples/..."
  extractor.extract_from_directory('examples')

  # Generate output files
  extractor.save_zeropoint_yml('config/zeropoint.yml')
  extractor.save_translations_yml('config/locales/extracted_translations.yml')
  extractor.save_replacement_script('scripts/pattern_replacements.txt')

  # Print summary and duplicates
  extractor.print_summary
  extractor.find_duplicates

  puts "\n✅ Extraction complete!"
  puts "📄 Check config/zeropoint.yml for logic patterns"
  puts "📄 Check config/locales/extracted_translations.yml for pure translations"
  puts "📄 Check scripts/pattern_replacements.txt for replacement instructions"
end
