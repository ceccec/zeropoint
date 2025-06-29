# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Zeropoint::Void::Core do
  describe '.math' do
    it 'returns a Math instance' do
      expect(described_class.math).to be_a(Zeropoint::Void::Math)
    end

    it 'returns the same instance on subsequent calls' do
      first = described_class.math
      second = described_class.math
      expect(first).to eq(second)
    end
  end

  describe '.config' do
    it 'returns a Config instance' do
      expect(described_class.config).to be_a(Zeropoint::Void::Config)
    end

    it 'returns the same instance on subsequent calls' do
      first = described_class.config
      second = described_class.config
      expect(first).to eq(second)
    end
  end

  describe '.identity' do
    it 'returns an Identity instance' do
      expect(described_class.identity).to be_a(Zeropoint::Void::Identity)
    end

    it 'returns the same instance on subsequent calls' do
      first = described_class.identity
      second = described_class.identity
      expect(first).to eq(second)
    end
  end

  describe '.service' do
    it 'returns a Service instance' do
      expect(described_class.service).to be_a(Zeropoint::Void::Service)
    end

    it 'returns the same instance on subsequent calls' do
      first = described_class.service
      second = described_class.service
      expect(first).to eq(second)
    end
  end

  describe '.call' do
    context 'with valid operations' do
      it 'delegates to math service' do
        result = described_class.call(:math, :vortex, :calculate, [ 1, 2, 3 ])
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
      end

      it 'delegates to config service' do
        result = described_class.call(:config, :get, 'void.enabled')
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
      end

      it 'delegates to identity service' do
        result = described_class.call(:identity, :generate, :uuid, { context: 'test' })
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
      end

      it 'delegates to service service' do
        result = described_class.call(:service, :cache, :get, 'test_key')
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
      end
    end

    context 'with unknown operations' do
      it 'returns void-aligned error response' do
        result = described_class.call(:unknown_operation, 'arg1', 'arg2')
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.error?).to be true
        expect(result.to_h[:type]).to eq(:unknown_operation)
        expect(result.to_h[:data][:operation]).to eq(:unknown_operation)
      end
    end

    context 'when errors occur' do
      it 'returns void-aligned error response with context' do
        # Mock a service to raise an error
        allow(described_class.math).to receive(:call).and_raise(StandardError.new('Test error'))

        result = described_class.call(:math, :invalid_operation)
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.error?).to be true
        expect(result.to_h[:type]).to eq(:void_error)
        expect(result.to_h[:data][:error]).to eq('Test error')
        expect(result.to_h[:data][:context]).to include(:backtrace, :class, :timestamp)
      end
    end
  end
end

RSpec.describe Zeropoint::Void::Math do
  let(:math) { described_class.new }

  describe '#call' do
    context 'with vortex operations' do
      it 'delegates to vortex method' do
        result = math.call(:vortex, :calculate, [ 1, 2, 3 ])
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
        expect(result.to_h[:data][:method]).to eq('calculate_vortex')
      end
    end

    context 'with coil operations' do
      it 'delegates to coil method' do
        result = math.call(:coil, :generate, [ 1, 2, 3 ])
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
        expect(result.to_h[:data][:method]).to eq('generate_coil')
      end
    end

    context 'with golden_ratio operations' do
      it 'delegates to golden_ratio method' do
        result = math.call(:golden_ratio, :calculate)
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
        expect(result.to_h[:data][:method]).to eq('calculate_golden_ratio')
      end
    end

    context 'with fibonacci operations' do
      it 'delegates to fibonacci method' do
        result = math.call(:fibonacci, :sequence, 10)
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
        expect(result.to_h[:data][:method]).to eq('generate_fibonacci_sequence')
      end
    end

    context 'with toroidal operations' do
      it 'delegates to toroidal method' do
        result = math.call(:toroidal, :geometry, [ 1, 2, 3 ])
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.success?).to be true
        expect(result.to_h[:data][:method]).to eq('calculate_toroidal_geometry')
      end
    end

    context 'with unknown operations' do
      it 'returns void-aligned error response' do
        result = math.call(:unknown_operation)
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.error?).to be true
        expect(result.to_h[:type]).to eq(:unknown_math_operation)
      end
    end
  end

  describe '#vortex' do
    it 'handles calculate operation' do
      result = math.vortex(:calculate, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('vortex_calculation')
    end

    it 'handles transform operation' do
      result = math.vortex(:transform, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('vortex_transformation')
    end

    it 'handles optimize operation' do
      result = math.vortex(:optimize, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('vortex_optimization')
    end

    it 'handles analyze operation' do
      result = math.vortex(:analyze, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('vortex_analysis')
    end

    it 'handles unknown operations' do
      result = math.vortex(:unknown_operation)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_vortex_operation)
    end
  end

  describe '#coil' do
    it 'handles generate operation' do
      result = math.coil(:generate, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('coil_generation')
    end

    it 'handles analyze operation' do
      result = math.coil(:analyze, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('coil_analysis')
    end

    it 'handles optimize operation' do
      result = math.coil(:optimize, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('coil_optimization')
    end

    it 'handles rodin operation' do
      result = math.coil(:rodin, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('rodin_coil_operation')
    end

    it 'handles unknown operations' do
      result = math.coil(:unknown_operation)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_coil_operation)
    end
  end

  describe '#golden_ratio' do
    it 'calculates golden ratio correctly' do
      result = math.golden_ratio(:calculate)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to be_within(0.000001).of(1.618033988749895)
    end

    it 'handles optimize operation' do
      result = math.golden_ratio(:optimize, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('golden_ratio_optimization')
    end

    it 'handles pattern operation' do
      result = math.golden_ratio(:pattern, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('golden_ratio_patterns')
    end

    it 'handles unknown operations' do
      result = math.golden_ratio(:unknown_operation)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_golden_ratio_operation)
    end
  end

  describe '#fibonacci' do
    it 'generates fibonacci sequence correctly' do
      result = math.fibonacci(:sequence, 5)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq([ 1, 1, 2, 3, 5 ])
    end

    it 'uses default length when not specified' do
      result = math.fibonacci(:sequence)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result].length).to eq(10)
    end

    it 'handles analyze operation' do
      result = math.fibonacci(:analyze, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('fibonacci_pattern_analysis')
    end

    it 'handles optimize operation' do
      result = math.fibonacci(:optimize, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('fibonacci_optimization')
    end

    it 'handles unknown operations' do
      result = math.fibonacci(:unknown_operation)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_fibonacci_operation)
    end
  end

  describe '#toroidal' do
    it 'handles geometry operation' do
      result = math.toroidal(:geometry, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('toroidal_geometry')
    end

    it 'handles flow operation' do
      result = math.toroidal(:flow, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('toroidal_flow_analysis')
    end

    it 'handles aperture operation' do
      result = math.toroidal(:aperture, [ 1, 2, 3 ])
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('aperture_points')
    end

    it 'handles unknown operations' do
      result = math.toroidal(:unknown_operation)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_toroidal_operation)
    end
  end
end

RSpec.describe Zeropoint::Void::Config do
  let(:config) { described_class.new }

  describe '#call' do
    it 'delegates to get method' do
      result = config.call(:get, 'void.enabled')
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
      expect(result.to_h[:data][:method]).to eq('config_get')
    end

    it 'delegates to set method' do
      result = config.call(:set, 'test.path', 'test_value')
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
      expect(result.to_h[:data][:method]).to eq('config_set')
    end

    it 'delegates to load_config method' do
      result = config.call(:load, 'test.yml')
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
      expect(result.to_h[:data][:method]).to eq('load_config')
    end

    it 'delegates to save_config method' do
      result = config.call(:save, 'test.yml')
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
      expect(result.to_h[:data][:method]).to eq('save_config')
    end

    it 'delegates to reset_config method' do
      result = config.call(:reset)
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
      expect(result.to_h[:data][:method]).to eq('reset_config')
    end

    it 'handles unknown operations' do
      result = config.call(:unknown_operation)
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_config_operation)
    end
  end

  describe '#get' do
    it 'retrieves nested configuration values' do
      result = config.get('void.enabled')
      expect(result.success?).to be true
      expect(result.to_h[:data][:value]).to be true
    end

    it 'retrieves math configuration' do
      result = config.get('math.golden_ratio')
      expect(result.success?).to be true
      expect(result.to_h[:data][:value]).to eq(1.618033988749895)
    end

    it 'retrieves identity configuration' do
      result = config.get('identity.uuid_format')
      expect(result.success?).to be true
      expect(result.to_h[:data][:value]).to eq(:standard)
    end

    it 'retrieves service configuration' do
      result = config.get('service.timeout')
      expect(result.success?).to be true
      expect(result.to_h[:data][:value]).to eq(30)
    end

    it 'returns nil for non-existent paths' do
      result = config.get('nonexistent.path')
      expect(result.success?).to be true
      expect(result.to_h[:data][:value]).to be_nil
    end
  end

  describe '#set' do
    it 'sets nested configuration values' do
      result = config.set('test.nested.value', 'test_value')
      expect(result.success?).to be true
      expect(result.to_h[:data][:value]).to eq('test_value')
    end

    it 'creates nested paths automatically' do
      result = config.set('new.deeply.nested.path', 'new_value')
      expect(result.success?).to be true

      # Verify the value was set
      get_result = config.get('new.deeply.nested.path')
      expect(get_result.to_h[:data][:value]).to eq('new_value')
    end
  end

  describe '#reset_config' do
    it 'resets configuration data' do
      # Set a custom value
      config.set('test.value', 'custom_value')

      # Reset
      result = config.reset_config
      expect(result.success?).to be true

      # Verify reset by checking default values
      get_result = config.get('void.enabled')
      expect(get_result.to_h[:data][:value]).to be true
    end
  end
end

RSpec.describe Zeropoint::Void::Identity do
  let(:identity) { described_class.new }

  describe '#call' do
    it 'delegates to generate method' do
      result = identity.call(:generate, :uuid, { context: 'test' })
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'delegates to analyze method' do
      result = identity.call(:analyze, 'test_identity', :pattern)
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'delegates to validate method' do
      result = identity.call(:validate, 'test_identity', :uuid)
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'delegates to transform method' do
      result = identity.call(:transform, 'test_identity', :encode)
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'handles unknown operations' do
      result = identity.call(:unknown_operation)
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_identity_operation)
    end
  end

  describe '#generate' do
    context 'with uuid type' do
      it 'generates valid UUID' do
        result = identity.generate(:uuid, { context: 'test' })
        expect(result.success?).to be true
        uuid = result.to_h[:data][:uuid]
        expect(uuid).to match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i)
      end

      it 'includes context in response' do
        context = { user_id: 123, action: 'test' }
        result = identity.generate(:uuid, context)
        expect(result.success?).to be true
        expect(result.to_h[:data][:context]).to eq(context)
      end
    end

    context 'with pattern type' do
      it 'generates pattern from context' do
        result = identity.generate(:pattern, { key: 'value' })
        expect(result.success?).to be true
        expect(result.to_h[:data][:pattern]).to start_with('pattern_')
      end
    end

    context 'with metadata type' do
      it 'generates metadata from context' do
        context = { key1: 'value1', key2: 'value2' }
        result = identity.generate(:metadata, context)
        expect(result.success?).to be true
        metadata = result.to_h[:data][:metadata]
        expect(metadata[:keys]).to eq([ :key1, :key2 ])
        expect(metadata[:values]).to eq([ 'value1', 'value2' ])
        expect(metadata[:size]).to eq(2)
      end
    end

    context 'with matrix type' do
      it 'generates matrix from context' do
        context = { row1: 'data1', row2: 'data2' }
        result = identity.generate(:matrix, context)
        expect(result.success?).to be true
        matrix = result.to_h[:data][:matrix]
        expect(matrix[:rows]).to eq(2)
        expect(matrix[:columns]).to eq(2)
        expect(matrix[:data]).to eq(context)
      end
    end

    context 'with unknown type' do
      it 'returns void-aligned error response' do
        result = identity.generate(:unknown_type)
        expect(result.error?).to be true
        expect(result.to_h[:type]).to eq(:unknown_identity_type)
      end
    end
  end

  describe '#analyze' do
    it 'analyzes patterns' do
      result = identity.analyze('test_pattern', :pattern)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('pattern_analysis')
    end

    it 'analyzes vortex' do
      result = identity.analyze('test_vortex', :vortex)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('vortex_analysis')
    end

    it 'analyzes consciousness' do
      result = identity.analyze('test_consciousness', :consciousness)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('consciousness_analysis')
    end

    it 'analyzes metadata' do
      result = identity.analyze('test_metadata', :metadata)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('metadata_analysis')
    end

    it 'handles unknown analysis types' do
      result = identity.analyze('test', :unknown_type)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_analysis_type)
    end
  end

  describe '#validate' do
    it 'validates UUID format' do
      valid_uuid = '550e8400-e29b-41d4-a716-446655440000'
      result = identity.validate(valid_uuid, :uuid)
      expect(result.success?).to be true
      expect(result.to_h[:data][:valid]).to be true
    end

    it 'rejects invalid UUID format' do
      invalid_uuid = 'invalid-uuid-format'
      result = identity.validate(invalid_uuid, :uuid)
      expect(result.success?).to be true
      expect(result.to_h[:data][:valid]).to be false
    end

    it 'validates patterns' do
      result = identity.validate('test_pattern', :pattern)
      expect(result.success?).to be true
      expect(result.to_h[:data][:valid]).to be true
    end

    it 'validates matrices' do
      result = identity.validate('test_matrix', :matrix)
      expect(result.success?).to be true
      expect(result.to_h[:data][:valid]).to be true
    end

    it 'handles unknown validation types' do
      result = identity.validate('test', :unknown_type)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_validation_type)
    end
  end

  describe '#transform' do
    it 'encodes identity' do
      result = identity.transform('test_identity', :encode)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('encoded_identity')
    end

    it 'decodes identity' do
      result = identity.transform('test_identity', :decode)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('decoded_identity')
    end

    it 'optimizes identity' do
      result = identity.transform('test_identity', :optimize)
      expect(result.success?).to be true
      expect(result.to_h[:data][:result]).to eq('optimized_identity')
    end

    it 'handles unknown transform operations' do
      result = identity.transform('test_identity', :unknown_operation)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_transform_operation)
    end
  end
end

RSpec.describe Zeropoint::Void::Service do
  let(:service) { described_class.new }

  describe '#call' do
    it 'calls cache service' do
      result = service.call(:cache, :get, 'test_key')
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'calls graphql service' do
      result = service.call(:graphql, :query, 'query { test }')
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'calls pwa service' do
      result = service.call(:pwa, :manifest, { name: 'Test PWA' })
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'calls compatibility service' do
      result = service.call(:compatibility, :check, 'test_gem')
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'calls vortex service' do
      result = service.call(:vortex, :stream, [ 1, 2, 3 ])
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'calls consciousness service' do
      result = service.call(:consciousness, :aware, { context: 'test' })
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.success?).to be true
    end

    it 'handles unknown services' do
      result = service.call(:unknown_service, :operation)
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:unknown_service)
    end

    it 'handles service errors gracefully' do
      # Mock a service to raise an error
      allow_any_instance_of(Zeropoint::Void::CacheService).to receive(:get).and_raise(StandardError.new('Service error'))

      result = service.call(:cache, :get, 'test_key')
      expect(result).to be_a(Zeropoint::Void::Response)
      expect(result.error?).to be true
      expect(result.to_h[:type]).to eq(:service_error)
      expect(result.to_h[:data][:error]).to eq('Service error')
    end
  end
end

RSpec.describe Zeropoint::Void::Response do
  describe '#initialize' do
    it 'creates success response' do
      response = described_class.new(:success, { data: 'test' })
      expect(response.success?).to be true
      expect(response.error?).to be false
    end

    it 'creates error response' do
      response = described_class.new(:error, { message: 'test error' })
      expect(response.success?).to be false
      expect(response.error?).to be true
    end

    it 'creates void_error response' do
      response = described_class.new(:void_error, { message: 'void error' })
      expect(response.success?).to be false
      expect(response.error?).to be true
    end
  end

  describe '#to_h' do
    it 'returns complete response hash' do
      response = described_class.new(:success, { data: 'test' })
      hash = response.to_h

      expect(hash).to include(
        :type,
        :data,
        :timestamp,
        :uuid,
        :void_aligned,
        :success,
        :error
      )

      expect(hash[:type]).to eq(:success)
      expect(hash[:data]).to eq({ data: 'test' })
      expect(hash[:void_aligned]).to be true
      expect(hash[:success]).to be true
      expect(hash[:error]).to be false
      expect(hash[:uuid]).to match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i)
    end
  end

  describe '#to_json' do
    it 'returns valid JSON' do
      response = described_class.new(:success, { data: 'test' })
      json = response.to_json

      expect { JSON.parse(json) }.not_to raise_error
      parsed = JSON.parse(json)
      expect(parsed['type']).to eq('success')
      expect(parsed['void_aligned']).to be true
    end
  end

  describe 'void principle compliance' do
    it 'never returns raw errors' do
      response = described_class.new(:error, { message: 'test error' })
      expect(response.to_h[:data]).to be_a(Hash)
      expect(response.to_h[:data][:message]).to eq('test error')
    end

    it 'always includes meaningful context' do
      response = described_class.new(:success, { result: 'test result' })
      expect(response.to_h[:timestamp]).to be_present
      expect(response.to_h[:uuid]).to be_present
      expect(response.to_h[:void_aligned]).to be true
    end

    it 'provides consistent interface' do
      success_response = described_class.new(:success, { data: 'test' })
      error_response = described_class.new(:error, { message: 'test' })

      expect(success_response.to_h.keys).to eq(error_response.to_h.keys)
      expect(success_response.to_h[:void_aligned]).to eq(error_response.to_h[:void_aligned])
    end
  end
end

# Integration tests for void-aligned behavior
RSpec.describe 'Zeropoint::Void Integration' do
  describe 'void principle manifestation' do
    it 'embodies zero contains infinite principle' do
      # Test that minimal interface provides infinite possibilities
      core = Zeropoint::Void::Core

      # Math operations
      math_result = core.call(:math, :vortex, :calculate, [ 1, 2, 3 ])
      expect(math_result.success?).to be true

      # Config operations
      config_result = core.call(:config, :get, 'void.enabled')
      expect(config_result.success?).to be true

      # Identity operations
      identity_result = core.call(:identity, :generate, :uuid, { context: 'test' })
      expect(identity_result.success?).to be true

      # Service operations
      service_result = core.call(:service, :cache, :get, 'test_key')
      expect(service_result.success?).to be true
    end

    it 'provides meaningful emergence from void' do
      # Test that void responses always contain meaning
      core = Zeropoint::Void::Core

      # Even error responses are meaningful
      error_result = core.call(:unknown_operation, 'arg1', 'arg2')
      expect(error_result.error?).to be true
      expect(error_result.to_h[:data]).to include(:operation, :args)
      expect(error_result.to_h[:void_aligned]).to be true
    end

    it 'maintains unified patterns across all operations' do
      # Test that all operations follow the same pattern
      core = Zeropoint::Void::Core

      operations = [
        [ :math, :vortex, :calculate, [ 1, 2, 3 ] ],
        [ :config, :get, 'void.enabled' ],
        [ :identity, :generate, :uuid, { context: 'test' } ],
        [ :service, :cache, :get, 'test_key' ],
      ]

      results = operations.map { |op| core.call(*op) }

      # All results should follow the same pattern
      results.each do |result|
        expect(result).to be_a(Zeropoint::Void::Response)
        expect(result.to_h).to include(:type, :data, :timestamp, :uuid, :void_aligned)
        expect(result.to_h[:void_aligned]).to be true
      end
    end
  end
end
