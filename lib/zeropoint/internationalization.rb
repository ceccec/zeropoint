# frozen_string_literal: true

module Zeropoint
  module Internationalization
    class << self
      # Set up internationalization
      def setup
        # Configure I18n backend
        setup_backend

        # Set default locale
        I18n.default_locale = Zeropoint.config.default_locale

        # Set available locales
        I18n.available_locales = Zeropoint.config.available_locales

        # Set fallback locale
        I18n.fallback_locales = [ Zeropoint.config.fallback_locale ]

        # Load translations
        load_translations
      end

      # Translate with context
      def translate(key, **options)
        locale = options.delete(:locale) || I18n.locale

        # Try database translation first
        db_translation = database_translate(key, locale)
        return db_translation if db_translation.present?

        # Fall back to file-based translation
        I18n.t(key, **options.merge(locale: locale))
      end

      # Localize objects
      def localize(object, **options)
        locale = options.delete(:locale) || I18n.locale
        I18n.l(object, **options.merge(locale: locale))
      end

      # Get translation for specific locale
      def translate_for_locale(key, locale, **options)
        I18n.with_locale(locale) do
          translate(key, **options)
        end
      end

      # Batch translate multiple keys
      def batch_translate(keys, locale: I18n.locale)
        keys.map { |key| [ key, translate(key, locale: locale) ] }.to_h
      end

      # Get all translations for a locale
      def translations_for_locale(locale)
        return {} unless locale.in?(Zeropoint.config.available_locales)

        # Get database translations
        db_translations = database_translations_for_locale(locale)

        # Merge with file translations
        file_translations = I18n.backend.send(:translations)[locale.to_sym] || {}

        # Defensive: ensure db_translations is not frozen before merging
        db_translations = db_translations.dup if db_translations.frozen?

        db_translations.deep_merge(file_translations)
      end

      # Cache translations
      def cache_translations(locale)
        return unless Zeropoint.config.translation_cache

        Rails.cache.write(
          "translations:#{locale}",
          translations_for_locale(locale),
          expires_in: 1.hour
        )
      end

      # Clear translation cache
      def clear_cache(locale = nil)
        if locale
          Rails.cache.delete("translations:#{locale}")
        else
          Zeropoint.config.available_locales.each do |loc|
            Rails.cache.delete("translations:#{loc}")
          end
        end
      end

      private

      def setup_backend
        case Zeropoint.config.i18n_backend
        when :database
          setup_database_backend
        when :hybrid
          setup_hybrid_backend
        else
          setup_file_backend
        end
      end

      def setup_database_backend
        # Use database backend for translations
        I18n.backend = I18n::Backend::Chain.new(
          I18n::Backend::Database.new,
          I18n::Backend::Simple.new
        )
      end

      def setup_hybrid_backend
        # Use both database and file backends
        I18n.backend = I18n::Backend::Chain.new(
          I18n::Backend::Database.new,
          I18n::Backend::Simple.new
        )
      end

      def setup_file_backend
        # Use file-based backend only
        I18n.backend = I18n::Backend::Simple.new
      end

      def load_translations
        # Load translations from config/locales
        I18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]
        I18n.reload!
      end

      def database_translate(key, locale)
        return nil unless defined?(Translation)

        # Try to get from cache first
        cached = Rails.cache.read("translation:#{locale}:#{key}")
        return cached if cached.present?

        # Get from database
        translation = Translation.find_by(key: key, locale: locale)
        return nil unless translation

        # Cache the result
        Rails.cache.write("translation:#{locale}:#{key}", translation.value, expires_in: 1.hour)

        translation.value
      rescue StandardError
        nil
      end

      def database_translations_for_locale(locale)
        return {} unless defined?(Translation)

        # Try to get from cache first
        cached = Rails.cache.read("translations:#{locale}")
        return cached if cached.present?

        # Get from database
        translations = Translation.where(locale: locale).pluck(:key, :value).to_h

        # Cache the result
        Rails.cache.write("translations:#{locale}", translations, expires_in: 1.hour)

        translations
      rescue StandardError
        {}
      end
    end
  end
end
