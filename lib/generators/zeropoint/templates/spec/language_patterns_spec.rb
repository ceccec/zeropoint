# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LanguageCookiePatterns do
  describe 'URL path patterns' do
    describe '.extract_language_from_path' do
      it 'extracts language from /lang/ path' do
        expect(described_class.extract_language_from_path('/en/')).to eq('en')
        expect(described_class.extract_language_from_path('/bg/')).to eq('bg')
        expect(described_class.extract_language_from_path('/de/posts')).to eq('de')
      end

      it 'extracts language from /lang-region/ path' do
        expect(described_class.extract_language_from_path('/en-US/')).to eq('en')
        expect(described_class.extract_language_from_path('/bg-BG/posts')).to eq('bg')
        expect(described_class.extract_language_from_path('/de-DE/')).to eq('de')
      end

      it 'extracts language from /region/lang/ path' do
        expect(described_class.extract_language_from_path('/US/en/')).to eq('en')
        expect(described_class.extract_language_from_path('/BG/bg/posts')).to eq('bg')
        expect(described_class.extract_language_from_path('/DE/de/')).to eq('de')
      end

      it 'returns nil for paths without language' do
        expect(described_class.extract_language_from_path('/posts')).to be_nil
        expect(described_class.extract_language_from_path('/')).to be_nil
        expect(described_class.extract_language_from_path('/users/123')).to be_nil
      end

      it 'returns nil for invalid language codes' do
        expect(described_class.extract_language_from_path('/xx/')).to be_nil
        expect(described_class.extract_language_from_path('/123/')).to be_nil
      end
    end
  end

  describe 'Cookie patterns' do
    describe '.extract_language_from_cookie' do
      it 'extracts language from standard lang cookie' do
        expect(described_class.extract_language_from_cookie('lang=en')).to eq('en')
        expect(described_class.extract_language_from_cookie('lang=bg')).to eq('bg')
        expect(described_class.extract_language_from_cookie('lang=de')).to eq('de')
      end

      it 'extracts language from lang-region cookie' do
        expect(described_class.extract_language_from_cookie('lang=en-US')).to eq('en')
        expect(described_class.extract_language_from_cookie('lang=bg-BG')).to eq('bg')
        expect(described_class.extract_language_from_cookie('lang=de-DE')).to eq('de')
      end

      it 'extracts language from zeropoint_lang cookie' do
        expect(described_class.extract_language_from_cookie('zeropoint_lang=en')).to eq('en')
        expect(described_class.extract_language_from_cookie('zeropoint_lang=bg')).to eq('bg')
      end

      it 'extracts language from session_lang cookie' do
        expect(described_class.extract_language_from_cookie('session_lang=en')).to eq('en')
        expect(described_class.extract_language_from_cookie('session_lang=bg')).to eq('bg')
      end

      it 'returns nil for invalid cookies' do
        expect(described_class.extract_language_from_cookie('invalid=en')).to be_nil
        expect(described_class.extract_language_from_cookie('lang=xx')).to be_nil
        expect(described_class.extract_language_from_cookie('lang=123')).to be_nil
      end
    end

    describe '.build_language_cookie' do
      it 'builds language cookie without region' do
        expect(described_class.build_language_cookie('en')).to eq('en')
        expect(described_class.build_language_cookie('bg')).to eq('bg')
      end

      it 'builds language cookie with region' do
        expect(described_class.build_language_cookie('en', 'US')).to eq('en-US')
        expect(described_class.build_language_cookie('bg', 'BG')).to eq('bg-BG')
      end
    end

    describe '.parse_language_cookie' do
      it 'parses language cookie without region' do
        result = described_class.parse_language_cookie('lang=en')
        expect(result[:language]).to eq('en')
        expect(result[:region]).to be_nil
      end

      it 'parses language cookie with region' do
        result = described_class.parse_language_cookie('lang=en-US')
        expect(result[:language]).to eq('en')
        expect(result[:region]).to eq('US')
      end

      it 'returns nil for invalid cookies' do
        expect(described_class.parse_language_cookie('invalid=en')).to be_nil
        expect(described_class.parse_language_cookie('lang=xx')).to be_nil
      end
    end
  end

  describe 'Query parameter patterns' do
    describe '.extract_language_from_query' do
      it 'extracts language from lang parameter' do
        expect(described_class.extract_language_from_query('lang=en')).to eq('en')
        expect(described_class.extract_language_from_query('lang=bg')).to eq('bg')
        expect(described_class.extract_language_from_query('?lang=en&page=1')).to eq('en')
      end

      it 'extracts language from locale parameter' do
        expect(described_class.extract_language_from_query('locale=en')).to eq('en')
        expect(described_class.extract_language_from_query('locale=bg')).to eq('bg')
        expect(described_class.extract_language_from_query('?locale=en&page=1')).to eq('en')
      end

      it 'extracts language from short l parameter' do
        expect(described_class.extract_language_from_query('l=en')).to eq('en')
        expect(described_class.extract_language_from_query('l=bg')).to eq('bg')
        expect(described_class.extract_language_from_query('?l=en&page=1')).to eq('en')
      end

      it 'returns nil for invalid query strings' do
        expect(described_class.extract_language_from_query('invalid=en')).to be_nil
        expect(described_class.extract_language_from_query('lang=xx')).to be_nil
        expect(described_class.extract_language_from_query('')).to be_nil
      end
    end
  end

  describe 'Header patterns' do
    describe '.extract_language_from_header' do
      it 'extracts language from Accept-Language header' do
        expect(described_class.extract_language_from_header('en')).to eq('en')
        expect(described_class.extract_language_from_header('bg')).to eq('bg')
        expect(described_class.extract_language_from_header('en-US')).to eq('en')
        expect(described_class.extract_language_from_header('bg-BG')).to eq('bg')
      end

      it 'extracts language with quality value' do
        expect(described_class.extract_language_from_header('en;q=0.9')).to eq('en')
        expect(described_class.extract_language_from_header('bg;q=0.8')).to eq('bg')
      end

      it 'handles multiple languages' do
        expect(described_class.extract_language_from_header('en, bg;q=0.9')).to eq('en')
        expect(described_class.extract_language_from_header('bg, en;q=0.9')).to eq('bg')
      end

      it 'returns nil for invalid headers' do
        expect(described_class.extract_language_from_header('xx')).to be_nil
        expect(described_class.extract_language_from_header('123')).to be_nil
        expect(described_class.extract_language_from_header('')).to be_nil
      end
    end
  end

  describe 'Domain patterns' do
    describe '.extract_language_from_domain' do
      it 'extracts language from country domains' do
        expect(described_class.extract_language_from_domain('example.bg')).to eq('bg')
        expect(described_class.extract_language_from_domain('example.de')).to eq('de')
        expect(described_class.extract_language_from_domain('example.fr')).to eq('fr')
      end

      it 'returns nil for unknown domains' do
        expect(described_class.extract_language_from_domain('example.com')).to be_nil
        expect(described_class.extract_language_from_domain('example.org')).to be_nil
      end

      it 'returns nil for invalid domains' do
        expect(described_class.extract_language_from_domain('')).to be_nil
        expect(described_class.extract_language_from_domain(nil)).to be_nil
      end
    end
  end

  describe 'Validation methods' do
    describe '.valid_language?' do
      it 'validates correct language codes' do
        expect(described_class.valid_language?('en')).to be true
        expect(described_class.valid_language?('bg')).to be true
        expect(described_class.valid_language?('de')).to be true
      end

      it 'rejects invalid language codes' do
        expect(described_class.valid_language?('xx')).to be false
        expect(described_class.valid_language?('123')).to be false
        expect(described_class.valid_language?('en-US')).to be false
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
        expect(described_class.valid_language_region?('xx-YY')).to be false
        expect(described_class.valid_language_region?('en-123')).to be false
        expect(described_class.valid_language_region?('')).to be false
        expect(described_class.valid_language_region?(nil)).to be false
      end
    end
  end

  describe 'URL manipulation methods' do
    describe '.remove_language_from_path' do
      it 'removes language from path' do
        expect(described_class.remove_language_from_path('/en/')).to eq('/')
        expect(described_class.remove_language_from_path('/bg/posts')).to eq('/posts')
        expect(described_class.remove_language_from_path('/de/users/123')).to eq('/users/123')
      end

      it 'removes language-region from path' do
        expect(described_class.remove_language_from_path('/en-US/')).to eq('/')
        expect(described_class.remove_language_from_path('/bg-BG/posts')).to eq('/posts')
      end

      it 'removes region-language from path' do
        expect(described_class.remove_language_from_path('/US/en/')).to eq('/')
        expect(described_class.remove_language_from_path('/BG/bg/posts')).to eq('/posts')
      end

      it 'returns path unchanged if no language' do
        expect(described_class.remove_language_from_path('/posts')).to eq('/posts')
        expect(described_class.remove_language_from_path('/')).to eq('/')
      end
    end

    describe '.add_language_to_path' do
      it 'adds language to path' do
        expect(described_class.add_language_to_path('/', 'en')).to eq('/en/')
        expect(described_class.add_language_to_path('/posts', 'bg')).to eq('/bg/posts')
        expect(described_class.add_language_to_path('/users/123', 'de')).to eq('/de/users/123')
      end

      it 'returns path unchanged for invalid language' do
        expect(described_class.add_language_to_path('/posts', 'xx')).to eq('/posts')
        expect(described_class.add_language_to_path('/posts', nil)).to eq('/posts')
      end
    end

    describe '.url_has_language?' do
      it 'detects language in URL' do
        expect(described_class.url_has_language?('/en/')).to be true
        expect(described_class.url_has_language?('/bg/posts')).to be true
        expect(described_class.url_has_language?('/en-US/')).to be true
        expect(described_class.url_has_language?('/US/en/')).to be true
      end

      it 'detects no language in URL' do
        expect(described_class.url_has_language?('/posts')).to be false
        expect(described_class.url_has_language?('/')).to be false
        expect(described_class.url_has_language?('/users/123')).to be false
      end
    end
  end

  describe 'Language information methods' do
    describe '.supported_languages' do
      it 'returns list of supported languages' do
        languages = described_class.supported_languages
        expect(languages).to include('en', 'bg', 'de', 'fr', 'es')
        expect(languages).to be_an(Array)
        expect(languages).not_to be_empty
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
        expect(described_class.supported_language?('123')).to be false
      end
    end

    describe '.fallback_language' do
      it 'returns fallback language' do
        expect(described_class.fallback_language).to eq('en')
      end
    end

    describe '.language_name' do
      it 'returns language names' do
        expect(described_class.language_name('en')).to eq('English')
        expect(described_class.language_name('bg')).to eq('Български')
        expect(described_class.language_name('de')).to eq('Deutsch')
      end

      it 'returns language code for unknown languages' do
        expect(described_class.language_name('xx')).to eq('xx')
        expect(described_class.language_name('123')).to eq('123')
      end
    end
  end

  describe 'Priority detection' do
    describe '.get_language_priority' do
      let(:request) { double('request') }

      it 'prioritizes URL path over other sources' do
        allow(request).to receive(:path).and_return('/bg/posts')
        allow(request).to receive(:query_string).and_return('')
        allow(request).to receive(:cookies).and_return({})
        allow(request).to receive(:headers).and_return({})
        allow(request).to receive(:host).and_return('example.com')

        expect(described_class.get_language_priority(request)).to eq('bg')
      end

      it 'prioritizes query parameter when no path language' do
        allow(request).to receive(:path).and_return('/posts')
        allow(request).to receive(:query_string).and_return('lang=de')
        allow(request).to receive(:cookies).and_return({})
        allow(request).to receive(:headers).and_return({})
        allow(request).to receive(:host).and_return('example.com')

        expect(described_class.get_language_priority(request)).to eq('de')
      end

      it 'prioritizes cookie when no path or query language' do
        allow(request).to receive(:path).and_return('/posts')
        allow(request).to receive(:query_string).and_return('')
        allow(request).to receive(:cookies).and_return({ lang: 'fr' })
        allow(request).to receive(:headers).and_return({})
        allow(request).to receive(:host).and_return('example.com')

        expect(described_class.get_language_priority(request)).to eq('fr')
      end

      it 'falls back to default language' do
        allow(request).to receive(:path).and_return('/posts')
        allow(request).to receive(:query_string).and_return('')
        allow(request).to receive(:cookies).and_return({})
        allow(request).to receive(:headers).and_return({})
        allow(request).to receive(:host).and_return('example.com')

        expect(described_class.get_language_priority(request)).to eq('en')
      end
    end
  end
end
