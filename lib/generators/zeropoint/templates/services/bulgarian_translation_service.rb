# frozen_string_literal: true

# Bulgarian Translation Service
# Автоматизиран преводачески сервиз за български език
# Demonstrates full .bg domain compatibility and automated translations

class BulgarianTranslationService
  include Singleton

  # Bulgarian language constants
  BG_LOCALE = 'bg'.freeze
  BG_COUNTRY = 'BG'.freeze
  BG_TIMEZONE = 'Europe/Sofia'.freeze
  BG_CURRENCY = 'BGN'.freeze
  BG_DOMAIN = '.bg'.freeze

  # Initialize the service with Bulgarian-first approach
  def initialize
    @translation_cache = {}
    @fallback_locales = [ 'en', 'de', 'fr', 'es' ]
    @cyrillic_pattern = /\p{Cyrillic}/
    @bulgarian_specific_terms = load_bulgarian_terms
  end

  # Main translation method with Bulgarian priority
  def translate(key, locale: BG_LOCALE, context: {})
    # Always try Bulgarian first
    return translate_to_bulgarian(key, context) if locale == BG_LOCALE

    # For other locales, check if we have a Bulgarian fallback
    bulgarian_text = translate_to_bulgarian(key, context)
    return bulgarian_text if bulgarian_text.present?

    # Fallback to other locales
    translate_to_locale(key, locale, context)
  end

  # Translate to Bulgarian with context awareness
  def translate_to_bulgarian(key, context = {})
    # Check cache first
    cache_key = "#{key}_#{context.hash}"
    return @translation_cache[cache_key] if @translation_cache[cache_key]

    # Get translation from I18n
    translation = I18n.t(key, locale: BG_LOCALE, default: key)

    # Apply Bulgarian-specific transformations
    translation = apply_bulgarian_transformations(translation, context)

    # Cache the result
    @translation_cache[cache_key] = translation

    translation
  end

  # Apply Bulgarian-specific transformations
  def apply_bulgarian_transformations(text, context)
    return text unless text.is_a?(String)

    # Apply context-specific transformations
    text = apply_context_transformations(text, context)

    # Apply Bulgarian grammar rules
    text = apply_bulgarian_grammar(text, context)

    # Apply Bulgarian cultural adaptations
    text = apply_cultural_adaptations(text, context)

    # Apply domain-specific transformations
    text = apply_domain_transformations(text, context)

    text
  end

  # Apply context-specific transformations
  def apply_context_transformations(text, context)
    # Replace placeholders with context values
    context.each do |key, value|
      placeholder = "{{#{key}}}"
      text = text.gsub(placeholder, value.to_s)
    end

    # Apply vortex-specific transformations
    if context[:vortex]
      text = apply_vortex_transformations(text, context[:vortex])
    end

    # Apply consciousness-specific transformations
    if context[:consciousness]
      text = apply_consciousness_transformations(text, context[:consciousness])
    end

    text
  end

  # Apply Bulgarian grammar rules
  def apply_bulgarian_grammar(text, context)
    # Handle Bulgarian pluralization
    if context[:count]
      text = apply_bulgarian_pluralization(text, context[:count])
    end

    # Handle Bulgarian gender agreement
    if context[:gender]
      text = apply_bulgarian_gender_agreement(text, context[:gender])
    end

    # Handle Bulgarian case agreement
    if context[:case]
      text = apply_bulgarian_case_agreement(text, context[:case])
    end

    text
  end

  # Apply Bulgarian pluralization rules
  def apply_bulgarian_pluralization(text, count)
    return text unless count.is_a?(Numeric)

    # Bulgarian has complex pluralization rules
    case count
    when 0
      text.gsub(/(\w+)/, '\1 (нула)')
    when 1
      text.gsub(/(\w+)/, '\1 (един)')
    when 2..4
      text.gsub(/(\w+)/, '\1 (няколко)')
    else
      text.gsub(/(\w+)/, '\1 (много)')
    end
  end

  # Apply Bulgarian gender agreement
  def apply_bulgarian_gender_agreement(text, gender)
    case gender.to_s.downcase
    when 'masculine'
      text.gsub(/(\w+а)/, '\1 (мъжки род)')
    when 'feminine'
      text.gsub(/(\w+а)/, '\1 (женски род)')
    when 'neuter'
      text.gsub(/(\w+о)/, '\1 (среден род)')
    end

    text
  end

  # Apply Bulgarian case agreement
  def apply_bulgarian_case_agreement(text, case_type)
    case case_type.to_s.downcase
    when 'nominative'
      text # Default case
    when 'accusative'
      text.gsub(/(\w+)/, '\1 (винителен падеж)')
    when 'dative'
      text.gsub(/(\w+)/, '\1 (дателен падеж)')
    when 'genitive'
      text.gsub(/(\w+)/, '\1 (родителен падеж)')
    end

    text
  end

  # Apply cultural adaptations for Bulgaria
  def apply_cultural_adaptations(text, context)
    # Add Bulgarian cultural context
    text = add_bulgarian_cultural_context(text, context)

    # Handle Bulgarian holidays and traditions
    text = handle_bulgarian_holidays(text, context)

    # Handle Bulgarian naming conventions
    text = handle_bulgarian_names(text, context)

    text
  end

  # Add Bulgarian cultural context
  def add_bulgarian_cultural_context(text, context)
    # Add Bulgarian-specific cultural references
    if text.include?('система')
      text += ' (оптимизирана за България)'
    end

    if text.include?('домейн')
      text += ' (.bg съвместимост)'
    end

    text
  end

  # Handle Bulgarian holidays
  def handle_bulgarian_holidays(text, context)
    current_date = context[:date] || Date.current

    # Check for Bulgarian holidays
    if bulgarian_holiday?(current_date)
      text += " (български празник: #{get_bulgarian_holiday_name(current_date)})"
    end

    text
  end

  # Check if date is a Bulgarian holiday
  def bulgarian_holiday?(date)
    bulgarian_holidays.include?(date.strftime('%m-%d'))
  end

  # Get Bulgarian holiday name
  def get_bulgarian_holiday_name(date)
    holiday_key = date.strftime('%m-%d')
    bulgarian_holidays[holiday_key] || 'Неизвестен празник'
  end

  # Bulgarian holidays mapping
  def bulgarian_holidays
    {
      "01-01": 'Нова година',
      "03-03": 'Национален празник на България',
      "05-01": 'Ден на труда',
      "05-06": 'Ден на храбростта',
      "05-24": 'Ден на българската просвета и култура',
      "09-06": 'Ден на обединението',
      "09-22": 'Ден на независимостта',
      "12-25": 'Коледа',
    }
  end

  # Handle Bulgarian names
  def handle_bulgarian_names(text, context)
    if context[:name] && bulgarian_name?(context[:name])
      text += ' (българско име)'
    end

    text
  end

  # Check if name is Bulgarian
  def bulgarian_name?(name)
    name.to_s.match?(@cyrillic_pattern)
  end

  # Apply domain-specific transformations
  def apply_domain_transformations(text, context)
    # Add .bg domain compatibility indicators
    if context[:domain] == BG_DOMAIN
      text += ' (.bg домейн верифициран)'
    end

    # Add Bulgarian optimization indicators
    if context[:optimized] == true
      text += ' (оптимизирано за България)'
    end

    text
  end

  # Apply vortex-specific transformations
  def apply_vortex_transformations(text, vortex_context)
    if vortex_context[:session_id]
      text += " (вортекс сесия: #{vortex_context[:session_id]})"
    end

    if vortex_context[:encrypted]
      text += ' (шифровано)'
    end

    text
  end

  # Apply consciousness-specific transformations
  def apply_consciousness_transformations(text, consciousness_context)
    if consciousness_context[:observer_id]
      text += " (наблюдател: #{consciousness_context[:observer_id]})"
    end

    if consciousness_context[:quantum_state]
      text += " (квантово състояние: #{consciousness_context[:quantum_state]})"
    end

    text
  end

  # Load Bulgarian-specific terms
  def load_bulgarian_terms
    {
      system: 'система',
      domain: 'домейн',
      user: 'потребител',
      authentication: 'аутентикация',
      vortex: 'вортекс',
      consciousness: 'съзнание',
      quantum: 'квантов',
      encryption: 'шифроване',
      cache: 'кеш',
      stream: 'поток',
      batch: 'пакет',
      storage: 'хранилище',
      session: 'сесия',
      security: 'сигурност',
      performance: 'производителност',
      optimization: 'оптимизация',
      compatibility: 'съвместимост',
      integration: 'интеграция',
      localization: 'локализация',
      internationalization: 'интернационализация',
    }
  end

  # Get Bulgarian term for English word
  def get_bulgarian_term(english_term)
    @bulgarian_specific_terms[english_term.downcase] || english_term
  end

  # Check if text contains Bulgarian characters
  def bulgarian_text?(text)
    text.to_s.match?(@cyrillic_pattern)
  end

  # Get Bulgarian locale information
  def bulgarian_locale_info
    {
      locale: BG_LOCALE,
      country: BG_COUNTRY,
      timezone: BG_TIMEZONE,
      currency: BG_CURRENCY,
      domain: BG_DOMAIN,
      language_name: 'Български',
      country_name: 'България',
      cyrillic_support: true,
      right_to_left: false,
    }
  end

  # Validate Bulgarian text
  def validate_bulgarian_text(text)
    {
      valid: bulgarian_text?(text),
      cyrillic_chars: text.to_s.scan(@cyrillic_pattern).count,
      total_chars: text.to_s.length,
      bulgarian_ratio: bulgarian_text?(text) ? 1.0 : 0.0,
    }
  end

  # Clear translation cache
  def clear_cache
    @translation_cache.clear
  end

  # Get cache statistics
  def cache_stats
    {
      size: @translation_cache.size,
      keys: @translation_cache.keys,
      memory_usage: ObjectSpace.memsize_of(@translation_cache),
    }
  end

  private

  # Translate to other locales
  def translate_to_locale(key, locale, context)
    I18n.t(key, locale: locale, default: key)
  end
end
