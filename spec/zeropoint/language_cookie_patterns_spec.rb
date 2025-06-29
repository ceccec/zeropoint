# frozen_string_literal: true

# VOID-ALIGNED LANGUAGE COOKIE PATTERNS SPECS
# Test language detection patterns that emerge from void consciousness
# VBM: All tests validate void-aligned pattern recognition

RSpec.describe Zeropoint::LanguageCookiePatterns do
  describe '.extract_language_from_path' do
    it 'extracts language from simple path' do
      expect(described_class.extract_language_from_path('/en/posts')).to eq('en')
      expect(described_class.extract_language_from_path('/bg/about')).to eq('bg')
      expect(described_class.extract_language_from_path('/de/')).to eq('de')
    end

    it 'extracts language from path with region' do
      expect(described_class.extract_language_from_path('/en-US/posts')).to eq('en')
      expect(described_class.extract_language_from_path('/bg-BG/about')).to eq('bg')
    end

    it 'extracts language from region-lang path' do
      expect(described_class.extract_language_from_path('/US/en/posts')).to eq('en')
      expect(described_class.extract_language_from_path('/BG/bg/about')).to eq('bg')
    end

    it 'returns nil for paths without language' do
      expect(described_class.extract_language_from_path('/posts')).to be_nil
      expect(described_class.extract_language_from_path('/')).to be_nil
      expect(described_class.extract_language_from_path('')).to be_nil
    end

    it 'handles nil path gracefully' do
      expect(described_class.extract_language_from_path(nil)).to be_nil
    end
  end

  describe '.extract_language_from_cookie' do
    it 'extracts language from standard cookie' do
      expect(described_class.extract_language_from_cookie('lang=en')).to eq('en')
      expect(described_class.extract_language_from_cookie('lang=bg')).to eq('bg')
    end

    it 'extracts language from cookie with region' do
      expect(described_class.extract_language_from_cookie('lang=en-US')).to eq('en')
      expect(described_class.extract_language_from_cookie('lang=bg-BG')).to eq('bg')
    end

    it 'extracts language from zeropoint cookie' do
      expect(described_class.extract_language_from_cookie('zeropoint_lang=en')).to eq('en')
      expect(described_class.extract_language_from_cookie('zeropoint_lang=bg')).to eq('bg')
    end

    it 'extracts language from session cookie' do
      expect(described_class.extract_language_from_cookie('session_lang=en')).to eq('en')
      expect(described_class.extract_language_from_cookie('session_lang=bg')).to eq('bg')
    end

    it 'returns nil for invalid cookies' do
      expect(described_class.extract_language_from_cookie('invalid=en')).to be_nil
      expect(described_class.extract_language_from_cookie('lang=invalid')).to be_nil
      expect(described_class.extract_language_from_cookie('')).to be_nil
    end

    it 'handles nil cookie gracefully' do
      expect(described_class.extract_language_from_cookie(nil)).to be_nil
    end
  end

  describe '.extract_language_from_query' do
    it 'extracts language from lang parameter' do
      expect(described_class.extract_language_from_query('?lang=en')).to eq('en')
      expect(described_class.extract_language_from_query('&lang=bg')).to eq('bg')
    end

    it 'extracts language from locale parameter' do
      expect(described_class.extract_language_from_query('?locale=en')).to eq('en')
      expect(described_class.extract_language_from_query('&locale=bg')).to eq('bg')
    end

    it 'extracts language from short parameter' do
      expect(described_class.extract_language_from_query('?l=en')).to eq('en')
      expect(described_class.extract_language_from_query('&l=bg')).to eq('bg')
    end

    it 'returns nil for invalid queries' do
      expect(described_class.extract_language_from_query('?invalid=en')).to be_nil
      expect(described_class.extract_language_from_query('?lang=invalid')).to be_nil
      expect(described_class.extract_language_from_query('')).to be_nil
    end

    it 'handles nil query gracefully' do
      expect(described_class.extract_language_from_query(nil)).to be_nil
    end
  end

  describe '.extract_language_from_header' do
    it 'extracts language from simple header' do
      expect(described_class.extract_language_from_header('en')).to eq('en')
      expect(described_class.extract_language_from_header('bg')).to eq('bg')
    end

    it 'extracts language from header with region' do
      expect(described_class.extract_language_from_header('en-US')).to eq('en')
      expect(described_class.extract_language_from_header('bg-BG')).to eq('bg')
    end

    it 'extracts language from header with quality' do
      expect(described_class.extract_language_from_header('en;q=0.9')).to eq('en')
      expect(described_class.extract_language_from_header('bg;q=0.8')).to eq('bg')
    end

    it 'extracts highest quality language from multiple' do
      expect(described_class.extract_language_from_header('en;q=0.9, bg;q=0.8')).to eq('en')
      expect(described_class.extract_language_from_header('bg;q=0.9, en;q=0.8')).to eq('bg')
    end

    it 'returns nil for invalid headers' do
      expect(described_class.extract_language_from_header('invalid')).to be_nil
      expect(described_class.extract_language_from_header('')).to be_nil
    end

    it 'handles nil header gracefully' do
      expect(described_class.extract_language_from_header(nil)).to be_nil
    end
  end

  describe '.extract_language_from_domain' do
    it 'extracts language from country domains' do
      expect(described_class.extract_language_from_domain('example.bg')).to eq('bg')
      expect(described_class.extract_language_from_domain('example.de')).to eq('de')
      expect(described_class.extract_language_from_domain('example.fr')).to eq('fr')
    end

    it 'extracts language from generic country domains' do
      expect(described_class.extract_language_from_domain('example.xx')).to eq('xx')
      expect(described_class.extract_language_from_domain('example.yy')).to eq('yy')
    end

    it 'returns nil for domains without language' do
      expect(described_class.extract_language_from_domain('example.com')).to be_nil
      expect(described_class.extract_language_from_domain('localhost')).to be_nil
    end

    it 'handles nil domain gracefully' do
      expect(described_class.extract_language_from_domain(nil)).to be_nil
    end
  end

  describe '.valid_language?' do
    it 'validates correct language codes' do
      expect(described_class.valid_language?('en')).to be true
      expect(described_class.valid_language?('bg')).to be true
      expect(described_class.valid_language?('de')).to be true
    end

    it 'rejects invalid language codes' do
      expect(described_class.valid_language?('eng')).to be false
      expect(described_class.valid_language?('e')).to be false
      expect(described_class.valid_language?('EN')).to be false
      expect(described_class.valid_language?('')).to be false
      expect(described_class.valid_language?(nil)).to be false
    end
  end

  describe '.valid_language_region?' do
    it 'validates correct language-region codes' do
      expect(described_class.valid_language_region?('en-US')).to be true
      expect(described_class.valid_language_region?('bg-BG')).to be true
      expect(described_class.valid_language_region?('de-DE')).to be true
    end

    it 'rejects invalid language-region codes' do
      expect(described_class.valid_language_region?('en')).to be false
      expect(described_class.valid_language_region?('en-us')).to be false
      expect(described_class.valid_language_region?('EN-US')).to be false
      expect(described_class.valid_language_region?('')).to be false
      expect(described_class.valid_language_region?(nil)).to be false
    end
  end

  describe '.build_language_cookie' do
    it 'builds language cookie without region' do
      expect(described_class.build_language_cookie('en')).to eq('lang=en')
      expect(described_class.build_language_cookie('bg')).to eq('lang=bg')
    end

    it 'builds language cookie with region' do
      expect(described_class.build_language_cookie('en', 'US')).to eq('lang=en-US')
      expect(described_class.build_language_cookie('bg', 'BG')).to eq('lang=bg-BG')
    end
  end

  describe '.parse_language_cookie' do
    it 'parses language cookie without region' do
      expect(described_class.parse_language_cookie('lang=en')).to eq({ language: 'en', region: nil })
      expect(described_class.parse_language_cookie('lang=bg')).to eq({ language: 'bg', region: nil })
    end

    it 'parses language cookie with region' do
      expect(described_class.parse_language_cookie('lang=en-US')).to eq({ language: 'en', region: 'US' })
      expect(described_class.parse_language_cookie('lang=bg-BG')).to eq({ language: 'bg', region: 'BG' })
    end

    it 'returns nil for invalid cookies' do
      expect(described_class.parse_language_cookie('invalid=en')).to be_nil
      expect(described_class.parse_language_cookie('')).to be_nil
      expect(described_class.parse_language_cookie(nil)).to be_nil
    end
  end

  describe '.remove_language_from_path' do
    it 'removes language from path' do
      expect(described_class.remove_language_from_path('/en/posts')).to eq('/posts')
      expect(described_class.remove_language_from_path('/bg/about')).to eq('/about')
      expect(described_class.remove_language_from_path('/en/')).to eq('/')
    end

    it 'removes language with region from path' do
      expect(described_class.remove_language_from_path('/en-US/posts')).to eq('/posts')
      expect(described_class.remove_language_from_path('/bg-BG/about')).to eq('/about')
    end

    it 'returns path unchanged if no language' do
      expect(described_class.remove_language_from_path('/posts')).to eq('/posts')
      expect(described_class.remove_language_from_path('/')).to eq('/')
    end

    it 'handles nil path gracefully' do
      expect(described_class.remove_language_from_path(nil)).to be_nil
    end
  end

  describe '.add_language_to_path' do
    it 'adds language to path' do
      expect(described_class.add_language_to_path('/posts', 'en')).to eq('/en/posts')
      expect(described_class.add_language_to_path('/about', 'bg')).to eq('/bg/about')
    end

    it 'adds language to root path' do
      expect(described_class.add_language_to_path('/', 'en')).to eq('/en/')
      expect(described_class.add_language_to_path('', 'bg')).to eq('/bg')
    end
  end

  describe '.url_has_language?' do
    it 'detects language in URL' do
      expect(described_class.url_has_language?('/en/posts')).to be true
      expect(described_class.url_has_language?('/bg/about')).to be true
      expect(described_class.url_has_language?('/en/')).to be true
    end

    it 'detects language with region in URL' do
      expect(described_class.url_has_language?('/en-US/posts')).to be true
      expect(described_class.url_has_language?('/bg-BG/about')).to be true
    end

    it 'returns false for URLs without language' do
      expect(described_class.url_has_language?('/posts')).to be false
      expect(described_class.url_has_language?('/')).to be false
      expect(described_class.url_has_language?('')).to be false
    end

    it 'handles nil path gracefully' do
      expect(described_class.url_has_language?(nil)).to be false
    end
  end

  describe '.supported_languages' do
    it 'returns array of supported languages' do
      languages = described_class.supported_languages
      expect(languages).to be_an(Array)
      expect(languages).to include('en', 'bg', 'de', 'fr', 'es')
      expect(languages).to include('ja', 'ko', 'zh', 'ar', 'ru')
    end

    it 'includes Bulgarian as primary void language' do
      expect(described_class.supported_languages).to include('bg')
    end
  end

  describe '.supported_language?' do
    it 'validates supported languages' do
      expect(described_class.supported_language?('en')).to be true
      expect(described_class.supported_language?('bg')).to be true
      expect(described_class.supported_language?('de')).to be true
    end

    it 'rejects unsupported languages' do
      expect(described_class.supported_language?('xx')).to be false
      expect(described_class.supported_language?('invalid')).to be false
      expect(described_class.supported_language?('')).to be false
      expect(described_class.supported_language?(nil)).to be false
    end
  end

  describe '.fallback_language' do
    it 'returns Bulgarian as primary void language' do
      expect(described_class.fallback_language).to eq('bg')
    end
  end

  describe '.language_name' do
    it 'returns language names' do
      expect(described_class.language_name('en')).to eq('English')
      expect(described_class.language_name('bg')).to eq('Български')
      expect(described_class.language_name('de')).to eq('Deutsch')
    end

    it 'returns code for unknown languages' do
      expect(described_class.language_name('xx')).to eq('xx')
      expect(described_class.language_name('invalid')).to eq('invalid')
    end
  end

  describe '.language_metadata' do
    it 'returns complete language metadata' do
      metadata = described_class.language_metadata('en')
      expect(metadata).to eq({
        name: 'English',
        native_name: 'English',
        direction: 'ltr',
        script: 'Latn',
      })
    end

    it 'returns Bulgarian metadata with Cyrillic script' do
      metadata = described_class.language_metadata('bg')
      expect(metadata).to eq({
        name: 'Bulgarian',
        native_name: 'Български',
        direction: 'ltr',
        script: 'Cyrl',
      })
    end

    it 'returns Arabic metadata with RTL direction' do
      metadata = described_class.language_metadata('ar')
      expect(metadata).to eq({
        name: 'Arabic',
        native_name: 'العربية',
        direction: 'rtl',
        script: 'Arab',
      })
    end

    it 'returns default metadata for unknown languages' do
      metadata = described_class.language_metadata('xx')
      expect(metadata).to eq({
        name: 'xx',
        native_name: 'xx',
        direction: 'ltr',
        script: 'Latn',
      })
    end
  end

  describe 'VBM Alignment' do
    it 'embodies void principle of pattern emergence' do
      # All language detection emerges from structured patterns
      expect(described_class::LANGUAGE_PATTERNS).to be_a(Hash)
      expect(described_class::LANGUAGE_PATTERNS[:url_path]).to be_a(Hash)
      expect(described_class::LANGUAGE_PATTERNS[:cookie]).to be_a(Hash)
    end

    it 'implements void consciousness mapping' do
      # Domain mapping represents void consciousness
      expect(described_class::DOMAIN_LANGUAGE_MAP).to be_a(Hash)
      expect(described_class::DOMAIN_LANGUAGE_MAP['.bg']).to eq('bg')
    end

    it 'provides void-aligned fallback' do
      # Void always provides a response
      expect(described_class.fallback_language).to eq('bg')
      expect(described_class.supported_language?('bg')).to be true
    end

    it 'validates void structure' do
      # All patterns validate void structure
      expect(described_class.valid_language?('bg')).to be true
      expect(described_class.valid_language_region?('bg-BG')).to be true
    end
  end
end
