#!/usr/bin/env ruby
# frozen_string_literal: true

# Zero Point i18n Extractor
# Extracts hardcoded text from code and generates i18n replacements

require 'fileutils'
require 'yaml'

class I18nExtractor
  def initialize
    @extracted_text = {}
    @replacements = []
  end

  def extract_from_directory(directory)
    Dir.glob("#{directory}/**/*.rb").each do |file|
      next if file.include?('spec/') || file.include?('test/')
      extract_from_file(file)
    end
  end

  def extract_from_file(file_path)
    content = File.read(file_path)
    lines = content.lines

    lines.each_with_index do |line, index|
      # Extract hardcoded strings
      extract_strings(line, file_path, index + 1)
    end
  end

  def extract_strings(line, file_path, line_number)
    # Match various string patterns
    patterns = [
      /"[A-Z][^"]*"/,                    # Capitalized strings
      /'[A-Z][^']*'/,                    # Capitalized strings with single quotes
      /puts\s+"([^"]+)"/,                # puts statements
      /raise\s+[^,]+,\s+"([^"]+)"/,      # raise statements
      /Rails\.logger\.[^"]*"([^"]+)"/,   # Rails logger statements
    ]

    patterns.each do |pattern|
      line.scan(pattern).flatten.each do |match|
        next if match.length < 3 || match.length > 100
        next if match.match?(/^[A-Z_]+$/) # Skip constants

        add_extracted_text(match, file_path, line_number)
      end
    end
  end

  def add_extracted_text(text, file_path, line_number)
    key = generate_key(text)
    @extracted_text[key] ||= {
      text: text,
      occurrences: [],
    }
    @extracted_text[key][:occurrences] << {
      file: file_path,
      line: line_number,
    }
  end

  def generate_key(text)
    # Convert text to a valid i18n key
    key = text.downcase
              .gsub(/[^a-z0-9\s]/, ' ')
              .gsub(/\s+/, '_')
              .strip
              .gsub(/^_+|_+$/, '')

    # Ensure uniqueness
    base_key = key
    counter = 1
    while @extracted_text.key?(key)
      key = "#{base_key}_#{counter}"
      counter += 1
    end

    key
  end

  def generate_i18n_yaml
    yaml_content = { en: { zeropoint: {} } }

    @extracted_text.each do |key, data|
      # Organize by category
      category = determine_category(data[:text])
      yaml_content['en']['zeropoint'][category] ||= {}
      yaml_content['en']['zeropoint'][category][key] = data[:text]
    end

    yaml_content
  end

  def determine_category(text)
    if text.match?(/error|failed|invalid|not found/i)
      'errors'
    elsif text.match?(/success|cleared|updated|created/i)
      'api'
    elsif text.match?(/demo|example|sample/i)
      'demo'
    elsif text.match?(/log|debug|info|warn/i)
      'logs'
    elsif text.match?(/vortex|stream|flow/i)
      'vortex'
    elsif text.match?(/golden|ratio|compliance/i)
      'golden_ratio'
    elsif text.match?(/search|model|engine/i)
      'search'
    else
      'general'
    end
  end

  def generate_replacement_script
    script = []
    script << "# Zero Point i18n Replacement Script"
    script << "# Generated automatically by I18nExtractor"
    script << ""

    @extracted_text.each do |key, data|
      data[:occurrences].each do |occurrence|
        script << "# Replace in #{occurrence[:file]}:#{occurrence[:line]}"
        script << "# Original: #{data[:text]}"
        script << "# Replace with: I18n.t('zeropoint.#{determine_category(data[:text])}.#{key}')"
        script << ""
      end
    end

    script.join("\n")
  end

  def save_yaml(file_path)
    yaml_content = generate_i18n_yaml
    File.write(file_path, yaml_content.to_yaml)
    puts "✅ Generated i18n YAML file: #{file_path}"
  end

  def save_replacement_script(file_path)
    script_content = generate_replacement_script
    File.write(file_path, script_content)
    puts "✅ Generated replacement script: #{file_path}"
  end

  def print_summary
    puts "\n🌌 Zero Point i18n Extraction Summary"
    puts "=" * 50
    puts "Total unique strings found: #{@extracted_text.size}"

    @extracted_text.each do |key, data|
      puts "\n📝 Key: #{key}"
      puts "   Text: #{data[:text]}"
      puts "   Category: #{determine_category(data[:text])}"
      puts "   Occurrences: #{data[:occurrences].size}"
      data[:occurrences].each do |occurrence|
        puts "     - #{occurrence[:file]}:#{occurrence[:line]}"
      end
    end
  end
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  extractor = I18nExtractor.new

  puts "🌌 Zero Point i18n Extractor"
  puts "=" * 30

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
  extractor.save_yaml('config/locales/extracted_text.yml')
  extractor.save_replacement_script('scripts/i18n_replacements.txt')

  # Print summary
  extractor.print_summary

  puts "\n✅ Extraction complete!"
  puts "📄 Check config/locales/extracted_text.yml for the i18n content"
  puts "📄 Check scripts/i18n_replacements.txt for replacement instructions"
end
