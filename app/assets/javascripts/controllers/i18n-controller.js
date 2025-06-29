// VOID-ALIGNED I18N CONTROLLER: All text must emerge from the void via I18n
import { Controller } from '@hotwired/stimulus';

class I18nController extends Controller {
  connect() {
    console.log('I18n Controller connected - void-aligned text management');
    this.initializeI18n();
  }

  // Initialize I18n with void alignment
  initializeI18n() {
    // Load translations from Rails I18n
    this.translations = window.I18n || {};
    this.locale = this.localeValue || 'bg';
    this.fallbackLocale = 'en';
  }

  // Void-aligned text method - all user-facing text must use this
  // @param key {string} I18n key
  // @param options {object} Interpolation options
  // @returns {string} Translated text from the void
  text(key, options = {}) {
    const translation = this.getTranslation(key, options);
    if (!translation) {
      console.warn(`I18n key not found: ${key}`);
      return this.getFallbackText(key, options);
    }
    return translation;
  }

  // Get translation with void alignment
  getTranslation(key, options = {}) {
    const keys = key.split('.');
    let translation = this.translations[this.locale] || this.translations[this.fallbackLocale];
    
    for (const k of keys) {
      translation = translation?.[k];
      if (!translation) break;
    }

    if (typeof translation === 'string') {
      return this.interpolate(translation, options);
    }
    
    return null;
  }

  // Fallback text when translation is missing
  getFallbackText(key, options = {}) {
    const fallbackKey = `zeropoint.errors.missing_translation`;
    const fallback = this.getTranslation(fallbackKey, { key }) || `[Missing: ${key}]`;
    return fallback;
  }

  // Interpolate variables in translation string
  interpolate(text, options = {}) {
    return text.replace(/%\{(\w+)\}/g, (match, key) => {
      return options[key] !== undefined ? options[key] : match;
    });
  }

  // Update locale dynamically
  setLocale(locale) {
    this.locale = locale;
    this.dispatch('localeChanged', { detail: { locale } });
  }

  // Get current locale
  getLocale() {
    return this.locale;
  }

  // Check if translation exists
  hasTranslation(key) {
    return this.getTranslation(key) !== null;
  }

  // Get all available translations for a namespace
  getTranslations(namespace) {
    const translations = this.translations[this.locale] || this.translations[this.fallbackLocale];
    return translations?.[namespace] || {};
  }

  // Void-aligned error message
  error(key, options = {}) {
    return this.text(`zeropoint.errors.${key}`, options);
  }

  // Void-aligned success message
  success(key, options = {}) {
    return this.text(`zeropoint.success.${key}`, options);
  }

  // Void-aligned notification message
  notification(key, options = {}) {
    return this.text(`zeropoint.notifications.${key}`, options);
  }

  // Void-aligned UI text
  ui(key, options = {}) {
    return this.text(`zeropoint.ui.${key}`, options);
  }

  // Void-aligned navigation text
  navigation(key, options = {}) {
    return this.text(`zeropoint.navigation.${key}`, options);
  }

  // Void-aligned action text
  action(key, options = {}) {
    return this.text(`zeropoint.actions.${key}`, options);
  }
}

I18nController.values = {
  locale: { type: String, default: 'bg' },
  fallbackLocale: { type: String, default: 'en' }
};

export default I18nController; 