#!/usr/bin/env ruby
# frozen_string_literal: true

# Zero Point Pattern Replacement Applicator
# Automatically applies pattern replacements to the codebase

require 'fileutils'
require 'yaml'

class ZeropointPatternReplacer
  def initialize
    @zeropoint_config = load_zeropoint_config
    @translations_config = load_translations_config
    @replacements_made = 0
    @files_modified = []
  end

  def load_zeropoint_config
    return {} unless File.exist?('config/zeropoint.yml')
    YAML.load_file('config/zeropoint.yml')
  rescue StandardError => e
    puts "⚠️  Warning: Could not load zeropoint.yml: #{e.message}"
    {}
  end

  def load_translations_config
    return {} unless File.exist?('config/locales/extracted_translations.yml')
    YAML.load_file('config/locales/extracted_translations.yml')
  rescue StandardError => e
    puts "⚠️  Warning: Could not load extracted_translations.yml: #{e.message}"
    {}
  end

  def apply_replacements
    puts "🌌 Zero Point Pattern Replacement Applicator"
    puts "=" * 50

    # Apply logic pattern replacements
    apply_logic_pattern_replacements

    # Apply translation replacements
    apply_translation_replacements

    print_summary
  end

  def apply_logic_pattern_replacements
    puts "\n🔧 Applying Logic Pattern Replacements..."

    patterns = @zeropoint_config.dig('zeropoint', 'patterns') || {}

    patterns.each do |category, category_patterns|
      puts "  📁 Category: #{category}"
      category_patterns.each do |key, pattern_text|
        apply_single_logic_pattern(pattern_text, key, category)
      end
    end
  end

  def apply_single_logic_pattern(pattern_text, key, category)
    # Find files that contain this pattern
    matching_files = find_files_with_pattern(pattern_text)

    matching_files.each do |file_path|
      next if should_skip_file?(file_path)

      if replace_in_file(file_path, pattern_text, generate_logic_pattern_replacement(key, category))
        @replacements_made += 1
        @files_modified << file_path unless @files_modified.include?(file_path)
      end
    end
  end

  def apply_translation_replacements
    puts "\n🌐 Applying Translation Replacements..."

    translations = @translations_config.dig('en', 'zeropoint') || {}

    translations.each do |category, category_translations|
      puts "  📁 Category: #{category}"
      category_translations.each do |key, translation_text|
        apply_single_translation(translation_text, key, category)
      end
    end
  end

  def apply_single_translation(translation_text, key, category)
    # Find files that contain this translation
    matching_files = find_files_with_pattern(translation_text)

    matching_files.each do |file_path|
      next if should_skip_file?(file_path)

      if replace_in_file(file_path, translation_text, generate_translation_replacement(key, category))
        @replacements_made += 1
        @files_modified << file_path unless @files_modified.include?(file_path)
      end
    end
  end

  def find_files_with_pattern(pattern)
    files = []

    # Search in lib, demo_app, examples directories
    [ 'lib', 'demo_app', 'examples' ].each do |dir|
      next unless Dir.exist?(dir)

      Dir.glob("#{dir}/**/*.rb").each do |file|
        content = File.read(file)
        if content.include?(pattern)
          files << file
        end
      end
    end

    files
  end

  def should_skip_file?(file_path)
    # Skip spec files, test files, and scripts
    file_path.include?('spec/') ||
    file_path.include?('test/') ||
    file_path.include?('scripts/') ||
    file_path.include?('examples/') # Skip example files to avoid breaking demos
  end

  def replace_in_file(file_path, original_text, replacement_text)
    content = File.read(file_path)

    if content.include?(original_text)
      new_content = content.gsub(original_text, replacement_text)

      if new_content != content
        File.write(file_path, new_content)
        puts "    ✅ #{file_path}: Replaced pattern"
        return true
      end
    end

    false
  end

  def generate_logic_pattern_replacement(key, category)
    # Generate the replacement using Zeropoint.config
    "Zeropoint.config.patterns['#{category}']['#{key}']"
  end

  def generate_translation_replacement(key, category)
    # Generate the replacement using I18n
    "I18n.t('zeropoint.#{category}.#{key}')"
  end

  def print_summary
    puts "\n📊 Replacement Summary"
    puts "=" * 30
    puts "Total replacements made: #{@replacements_made}"
    puts "Files modified: #{@files_modified.size}"

    if @files_modified.any?
      puts "\n📁 Modified Files:"
      @files_modified.each do |file|
        puts "  - #{file}"
      end
    end

    puts "\n✅ Pattern replacement complete!"
    puts "💡 Next steps:"
    puts "   1. Review the changes in the modified files"
    puts "   2. Test the application to ensure functionality is preserved"
    puts "   3. Update any remaining hardcoded strings manually"
  end

  def create_backup
    timestamp = Time.zone.now.strftime("%Y%m%d_%H%M%S")
    backup_dir = "backups/pattern_replacement_#{timestamp}"

    FileUtils.mkdir_p(backup_dir)

    @files_modified.each do |file_path|
      backup_path = File.join(backup_dir, file_path)
      FileUtils.mkdir_p(File.dirname(backup_path))
      FileUtils.cp(file_path, backup_path)
    end

    puts "💾 Backup created at: #{backup_dir}"
  end
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  replacer = ZeropointPatternReplacer.new

  # Ask for confirmation
  puts "⚠️  This will modify files in your codebase."
  print "Do you want to proceed? (y/N): "
  response = gets.chomp.downcase

  if response == 'y' || response == 'yes'
    replacer.apply_replacements
    replacer.create_backup
  else
    puts "❌ Operation cancelled."
  end
end
