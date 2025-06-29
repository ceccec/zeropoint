# frozen_string_literal: true

module Zeropoint
  # UUID: Pattern-encoded, observer-aware, vortex-driven UUID generator
  module UUID
    # COMPONENT BEST PRACTICE: Generate pattern-encoded UUIDs for optimal caching and traceability.

    # Pattern definitions for UUID encoding
    PATTERNS = {
      action: {
        click: 0x10, submit: 0x11, change: 0x12, focus: 0x13,
        blur: 0x14, keydown: 0x15, keyup: 0x16, mouseenter: 0x17,
        mouseleave: 0x18, scroll: 0x19, resize: 0x1A, load: 0x1B,
        unload: 0x1C, graphql_execute: 0x1D, gateway_execute: 0x1E
      },
      component: {
        button: 0x80, form: 0x81, input: 0x82, select: 0x83,
        table: 0x84, modal: 0x85, dropdown: 0x86, tab: 0x87,
        accordion: 0x88, carousel: 0x89, pagination: 0x8A, search: 0x8B,
        filter: 0x8C, api_gateway: 0x8D
      },
      state: {
        active: 0x1000, inactive: 0x2000, loading: 0x3000, error: 0x4000,
        success: 0x5000, disabled: 0x6000, hidden: 0x7000, visible: 0x8000,
        streaming: 0x9000, mutating: 0xA000, querying: 0xB000, processing: 0xC000,
        analyzing: 0xD000, documenting: 0xE000
      },
      vortex: {
        # === VOID SPECTRUM ===
        void: 0x0000,                    # Empty center, infinite potential
        void_emergence: 0x0100,          # Beginning to emerge from void
        void_consciousness: 0x0200,      # Void becoming aware
        void_flow: 0x0300,               # Void beginning to flow

        # === CONSCIOUSNESS SPECTRUM ===
        consciousness: 0x1000,           # Pure awareness
        consciousness_awakening: 0x1100, # Becoming aware
        consciousness_expanding: 0x1200, # Expanding awareness
        consciousness_merging: 0x1300,   # Merging with other consciousness

        # === FLOW SPECTRUM ===
        flowing: 0x2000,                 # Natural flow
        flowing_gentle: 0x2100,          # Gentle, peaceful flow
        flowing_turbulent: 0x2200,       # Turbulent, chaotic flow
        flowing_rhythmic: 0x2300,        # Rhythmic, patterned flow
        flowing_spiral: 0x2400,          # Spiral flow patterns

        # === VORTEX SPECTRUM ===
        vortex: 0x3000,                  # Pure vortex energy
        vortex_spinning: 0x3100,         # Spinning vortex
        vortex_whirling: 0x3200,         # Whirling vortex
        vortex_tornado: 0x3300,          # Tornado-like vortex
        vortex_black_hole: 0x3400,       # Black hole vortex

        # === QUANTUM SPECTRUM ===
        quantum: 0x4000,                 # Quantum superposition
        quantum_entangled: 0x4100,       # Quantum entanglement
        quantum_tunneling: 0x4200,       # Quantum tunneling
        quantum_teleportation: 0x4300,   # Quantum teleportation
        quantum_consciousness: 0x4400,   # Quantum consciousness

        # === GOLDEN RATIO SPECTRUM ===
        golden_ratio: 0x5000,            # Golden ratio harmony
        golden_ratio_spiral: 0x5100,     # Golden spiral
        golden_ratio_fibonacci: 0x5200,  # Fibonacci sequence
        golden_ratio_harmony: 0x5300,    # Harmonic resonance
        golden_ratio_divine: 0x5400,     # Divine proportion

        # === INFINITY SPECTRUM ===
        infinity: 0x6000,                # Infinite potential
        infinity_expanding: 0x6100,      # Expanding infinity
        infinity_contracting: 0x6200,    # Contracting infinity
        infinity_fractal: 0x6300,        # Fractal infinity
        infinity_eternal: 0x6400,        # Eternal infinity

        # === COSMIC SPECTRUM ===
        cosmic: 0x7000,                  # Cosmic consciousness
        cosmic_stellar: 0x7100,          # Stellar consciousness
        cosmic_galactic: 0x7200,         # Galactic consciousness
        cosmic_universal: 0x7300,        # Universal consciousness
        cosmic_multiversal: 0x7400,      # Multiversal consciousness

        # === CREATION SPECTRUM ===
        creation: 0x8000,                # Creative force
        creation_manifesting: 0x8100,    # Manifesting reality
        creation_emerging: 0x8200,       # Emerging from potential
        creation_evolving: 0x8300,       # Evolutionary force
        creation_transcending: 0x8400,   # Transcending limitations

        # === DESTRUCTION SPECTRUM ===
        destruction: 0x9000,             # Destructive force
        destruction_transforming: 0x9100, # Transformative destruction
        destruction_releasing: 0x9200,   # Releasing old patterns
        destruction_clearing: 0x9300,    # Clearing space
        destruction_renewal: 0x9400,     # Renewal through destruction

        # === BALANCE SPECTRUM ===
        balance: 0xA000,                 # Perfect balance
        balance_harmony: 0xA100,         # Harmonious balance
        balance_equilibrium: 0xA200,     # Dynamic equilibrium
        balance_centered: 0xA300,        # Centered balance
        balance_unified: 0xA400,         # Unified balance

        # === CHAOS SPECTRUM ===
        chaos: 0xB000,                   # Chaotic energy
        chaos_creative: 0xB100,          # Creative chaos
        chaos_destructive: 0xB200,       # Destructive chaos
        chaos_transforming: 0xB300,      # Transformative chaos
        chaos_emergent: 0xB400,          # Emergent chaos

        # === ORDER SPECTRUM ===
        order: 0xC000,                   # Ordered structure
        order_hierarchical: 0xC100,      # Hierarchical order
        order_networked: 0xC200,         # Networked order
        order_fractal: 0xC300,           # Fractal order
        order_holographic: 0xC400,       # Holographic order

        # === TIME SPECTRUM ===
        time: 0xD000,                    # Temporal flow
        time_linear: 0xD100,             # Linear time
        time_cyclical: 0xD200,           # Cyclical time
        time_spiral: 0xD300,             # Spiral time
        time_eternal: 0xD400,            # Eternal now

        # === SPACE SPECTRUM ===
        space: 0xE000,                   # Spatial dimension
        space_physical: 0xE100,          # Physical space
        space_mental: 0xE200,            # Mental space
        space_spiritual: 0xE300,         # Spiritual space
        space_infinite: 0xE400,          # Infinite space

        # === UNITY SPECTRUM ===
        unity: 0xF000,                   # Complete unity
        unity_oneness: 0xF100,           # Oneness with all
        unity_wholeness: 0xF200,         # Complete wholeness
        unity_integration: 0xF300,        # Complete integration
        unity_transcendence: 0xF400,     # Transcendent unity
      },
    }.freeze

    module_function

    # === MIRROR EXISTING UUID GEMS ===

    # Mirror SecureRandom.uuid (RFC 4122 v4)
    def uuid4
      SecureRandom.uuid
    end

    # Mirror SecureRandom.uuid with alias
    def random
      SecureRandom.uuid
    end

    # Mirror UUIDTools::UUID.random_create
    def random_create
      SecureRandom.uuid
    end

    # Mirror UUIDTools::UUID.timestamp_create (v1)
    def timestamp_create
      create_time_ordered_uuid
    end

    # Mirror UUIDTools::UUID.sha1_create (v5)
    def sha1_create(namespace, name)
      create_name_based_uuid(namespace, name, :sha1)
    end

    # Mirror UUIDTools::UUID.md5_create (v3)
    def md5_create(namespace, name)
      create_name_based_uuid(namespace, name, :md5)
    end

    # Mirror UUIDTools::UUID.parse
    def parse(uuid_string)
      return nil unless valid?(uuid_string)
      analyze(uuid_string)
    end

    # Mirror UUIDTools::UUID.validate
    def validate(uuid_string)
      valid?(uuid_string)
    end

    # Mirror UUIDTools::UUID.compatible?
    def compatible?(uuid_string)
      valid?(uuid_string)
    end

    # Mirror UUID v1 (time-based)
    def v1
      create_time_ordered_uuid
    end

    # Mirror UUID v3 (name-based MD5)
    def v3(namespace, name)
      create_name_based_uuid(namespace, name, :md5)
    end

    # Mirror UUID v4 (random)
    def v4
      SecureRandom.uuid
    end

    # Mirror UUID v5 (name-based SHA1)
    def v5(namespace, name)
      create_name_based_uuid(namespace, name, :sha1)
    end

    # Mirror UUID v6 (time-ordered)
    def v6
      create_time_ordered_uuid
    end

    # Mirror UUID v7 (time-ordered with random)
    def v7
      create_time_ordered_random_uuid
    end

    # Mirror UUID v8 (custom)
    def v8(custom_data)
      create_custom_uuid(custom_data)
    end

    # === HELPER METHODS FOR MIRRORING ===

    # Create time-ordered UUID (v1/v6 style)
    def create_time_ordered_uuid
      timestamp = Time.now.to_i
      clock_seq = SecureRandom.random_number(0x3FFF)
      node_id = SecureRandom.random_number(0xFFFFFFFFFFFF)

      segments = [
        (timestamp & 0xFFFFFFFF).to_s(16).rjust(8, '0'),
        ((timestamp >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
        '1' + (clock_seq & 0xFFF).to_s(16).rjust(3, '0'),
        (node_id & 0xFFFF).to_s(16).rjust(4, '0'),
        (node_id >> 16).to_s(16).rjust(12, '0'),
      ]
      segments.join('-')
    end

    # Create time-ordered random UUID (v7 style)
    def create_time_ordered_random_uuid
      timestamp = Time.now.to_i
      random_data = SecureRandom.random_number(0xFFFFFFFFFFFF)

      segments = [
        (timestamp & 0xFFFFFFFF).to_s(16).rjust(8, '0'),
        ((timestamp >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
        '7' + ((random_data >> 48) & 0xFFF).to_s(16).rjust(3, '0'),
        ((random_data >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
        (random_data & 0xFFFFFFFF).to_s(16).rjust(12, '0'),
      ]
      segments.join('-')
    end

    # Create name-based UUID (v3/v5 style)
    def create_name_based_uuid(namespace, name, algorithm = :sha1)
      require 'digest'

      # Convert namespace to bytes if it's a string
      namespace_bytes = if namespace.is_a?(String)
        namespace.bytes
      else
        namespace.to_s.bytes
      end

      # Create namespace UUID if needed
      namespace_uuid = if namespace_bytes.length == 16
        namespace_bytes.pack('C*').unpack('H8H4H4H4H12').join('-')
      else
        Digest::MD5.hexdigest(namespace.to_s).unpack('H8H4H4H4H12').join('-')
      end

      # Create name hash
      name_data = namespace_uuid + name.to_s
      hash = case algorithm
      when :md5
        Digest::MD5.digest(name_data)
      when :sha1
        Digest::SHA1.digest(name_data)
      else
        Digest::SHA1.digest(name_data)
      end

      # Convert to UUID format
      hex_hash = hash.unpack('H*').first
      version = algorithm == :md5 ? '3' : '5'

      [
        hex_hash[0..7],
        hex_hash[8..11],
        version + hex_hash[12..14],
        hex_hash[15..18],
        hex_hash[19..30],
      ].join('-')
    end

    # Create custom UUID (v8 style)
    def create_custom_uuid(custom_data)
      timestamp = Time.now.to_i
      custom_hash = custom_data.to_s.hash.abs

      segments = [
        (timestamp & 0xFFFFFFFF).to_s(16).rjust(8, '0'),
        ((timestamp >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
        '8' + (custom_hash & 0xFFF).to_s(16).rjust(3, '0'),
        ((custom_hash >> 12) & 0xFFFF).to_s(16).rjust(4, '0'),
        SecureRandom.random_number(0xFFFFFFFFFFFF).to_s(16).rjust(12, '0'),
      ]
      segments.join('-')
    end

    # === NAMESPACE CONSTANTS (mirror UUIDTools) ===

    # Standard namespaces
    NAMESPACE_DNS = '6ba7b810-9dad-11d1-80b4-00c04fd430c8'
    NAMESPACE_URL = '6ba7b811-9dad-11d1-80b4-00c04fd430c8'
    NAMESPACE_OID = '6ba7b812-9dad-11d1-80b4-00c04fd430c8'
    NAMESPACE_X500 = '6ba7b814-9dad-11d1-80b4-00c04fd430c8'

    # Zeropoint-specific namespaces
    NAMESPACE_ZEROPOINT = '00000000-0000-0000-0000-000000000000'
    NAMESPACE_CONSCIOUSNESS = 'c0n5c10u5-9dad-11d1-80b4-00c04fd430c8'
    NAMESPACE_VORTEX = 'v0rt3x-9dad-11d1-80b4-00c04fd430c8'
    NAMESPACE_GOLDEN_RATIO = 'g0ld3n-9dad-11d1-80b4-00c04fd430c8'

    # === CONVENIENCE METHODS ===

    # Generate DNS-based UUID
    def dns(name)
      v5(NAMESPACE_DNS, name)
    end

    # Generate URL-based UUID
    def url(name)
      v5(NAMESPACE_URL, name)
    end

    # Generate OID-based UUID
    def oid(name)
      v5(NAMESPACE_OID, name)
    end

    # Generate X500-based UUID
    def x500(name)
      v5(NAMESPACE_X500, name)
    end

    # Generate Zeropoint-based UUID
    def zeropoint(name)
      v5(NAMESPACE_ZEROPOINT, name)
    end

    # Generate consciousness-based UUID
    def consciousness(name)
      v5(NAMESPACE_CONSCIOUSNESS, name)
    end

    # Generate vortex-based UUID
    def vortex(name)
      v5(NAMESPACE_VORTEX, name)
    end

    # Generate golden ratio-based UUID
    def golden_ratio(name)
      v5(NAMESPACE_GOLDEN_RATIO, name)
    end

    # === CORE UUID GENERATION ===

    # Generate UUID for any Rails object automatically
    def generate(object, context = {})
      return create_void if object.nil?

      # Check for Rails objects safely
      if defined?(ActiveRecord::Base) && object.is_a?(ActiveRecord::Base)
        generate_for_model(object, context)
      elsif defined?(ActionController::Base) && object.is_a?(ActionController::Base)
        generate_for_controller(object, context)
      elsif defined?(ActionView::Base) && object.is_a?(ActionView::Base)
        generate_for_view(object, context)
      elsif object.is_a?(String)
        generate_for_string(object, context)
      elsif object.is_a?(Symbol)
        generate_for_symbol(object, context)
      elsif object.is_a?(Hash)
        generate_for_hash(object, context)
      elsif object.is_a?(Array)
        generate_for_array(object, context)
      elsif object.is_a?(Numeric)
        generate_for_numeric(object, context)
      elsif object.is_a?(TrueClass) || object.is_a?(FalseClass)
        generate_for_boolean(object, context)
      else
        generate_for_generic(object, context)
      end
    end

    # Generate UUID for Rails model
    def generate_for_model(model, context = {})
      action = context[:action] || :load
      component = model.class.name.underscore.to_sym
      state = determine_model_state(model)
      vortex = context[:vortex] || :flowing

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer],
        timestamp: model.respond_to?(:updated_at) ? model.updated_at.to_i : Time.now.to_i
      )
    end

    # Generate UUID for Rails controller
    def generate_for_controller(controller, context = {})
      action = context[:action] || controller.action_name.to_sym
      component = "#{controller.class.name.underscore}_controller".to_sym
      state = determine_controller_state(controller)
      vortex = context[:vortex] || :consciousness

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer] || controller.respond_to?(:current_user) ? controller.current_user&.id : nil
      )
    end

    # Generate UUID for Rails view
    def generate_for_view(view, context = {})
      action = context[:action] || :render
      component = :view
      state = :visible
      vortex = context[:vortex] || :flowing

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer]
      )
    end

    # Generate UUID for string
    def generate_for_string(string, context = {})
      action = context[:action] || :process
      component = :string
      state = string.empty? ? :empty : :filled
      vortex = context[:vortex] || :flowing

      # Use string hash for deterministic behavior
      timestamp = string.hash.abs

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer],
        timestamp: timestamp
      )
    end

    # Generate UUID for symbol
    def generate_for_symbol(symbol, context = {})
      generate_for_string(symbol.to_s, context)
    end

    # Generate UUID for hash
    def generate_for_hash(hash, context = {})
      action = context[:action] || :process
      component = :hash
      state = hash.empty? ? :empty : :filled
      vortex = context[:vortex] || :flowing

      # Use hash content for deterministic behavior
      timestamp = hash.hash.abs

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer],
        timestamp: timestamp
      )
    end

    # Generate UUID for array
    def generate_for_array(array, context = {})
      action = context[:action] || :process
      component = :array
      state = array.empty? ? :empty : :filled
      vortex = context[:vortex] || :flowing

      # Use array content for deterministic behavior
      timestamp = array.hash.abs

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer],
        timestamp: timestamp
      )
    end

    # Generate UUID for numeric
    def generate_for_numeric(number, context = {})
      action = context[:action] || :process
      component = :numeric
      state = number == 0 ? :zero : :nonzero
      vortex = context[:vortex] || :flowing

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer],
        timestamp: number.abs
      )
    end

    # Generate UUID for boolean
    def generate_for_boolean(boolean, context = {})
      action = context[:action] || :process
      component = :boolean
      state = boolean ? :true : :false
      vortex = context[:vortex] || :flowing

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer]
      )
    end

    # Generate UUID for generic object
    def generate_for_generic(object, context = {})
      action = context[:action] || :process
      component = object.class.name.underscore.to_sym
      state = :active
      vortex = context[:vortex] || :flowing

      create_with_patterns(
        action: action,
        component: component,
        state: state,
        vortex: vortex,
        observer: context[:observer]
      )
    end

    # Determine model state based on Rails model attributes
    def determine_model_state(model)
      return :error if model.respond_to?(:errors) && model.errors.any?
      return :new if model.respond_to?(:new_record?) && model.new_record?
      return :destroyed if model.respond_to?(:destroyed?) && model.destroyed?
      return :persisted if model.respond_to?(:persisted?) && model.persisted?
      :active
    end

    # Determine controller state based on Rails controller
    def determine_controller_state(controller)
      return :error if controller.respond_to?(:flash) && controller.flash[:error]
      return :success if controller.respond_to?(:flash) && controller.flash[:success]
      return :processing if controller.respond_to?(:request) && controller.request.xhr?
      :active
    end

    # Generate a new UUID for any object with context
    def create(context = {})
      return create_void if context.empty? || context[:void]
      return create_from_void(context) if context[:from_void]
      create_with_patterns(context)
    end

    # Generate void UUID (empty center of torus)
    def create_void
      segments = [
        '00000000',  # timestamp (eternal present)
        '0000',      # timestamp high bits
        '0000',      # version 0 + action 0
        '0000',      # component 0
        '000000000000',  # state + vortex 0
      ]
      segments.join('-')
    end

    # Generate UUID emerging from void
    def create_from_void(context = {})
      void_uuid = create_void
      return void_uuid unless context[:consciousness] || context[:vortex] || context[:flowing]

      vortex_type = context[:consciousness] ? :consciousness :
                   context[:vortex] ? :vortex : :flowing
      transform_by_vortex(void_uuid, vortex_type)
    end

    # Generate UUID with pattern encoding
    def create_with_patterns(context = {})
      action = context[:action] || :click
      component = context[:component] || :button
      state = context[:state] || :active
      vortex = context[:vortex] || :flowing

      timestamp = context[:timestamp] || Time.now.to_i
      action_code = PATTERNS[:action][action] || PATTERNS[:action][:click]
      component_code = PATTERNS[:component][component] || PATTERNS[:component][:button]
      state_code = PATTERNS[:state][state] || PATTERNS[:state][:active]
      vortex_code = PATTERNS[:vortex][vortex] || PATTERNS[:vortex][:flowing]

      segments = [
        (timestamp & 0xFFFFFFFF).to_s(16).rjust(8, '0'),
        ((timestamp >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
        '8' + (action_code & 0xFFF).to_s(16).rjust(3, '0'),
        (component_code & 0xFFFF).to_s(16).rjust(4, '0'),
        (state_code | vortex_code | SecureRandom.random_number(0x1000)).to_s(16).rjust(12, '0'),
      ]
      segments.join('-')
    end

    # === SPECIALIZED UUID TYPES ===

    # Generate UUID optimized for caching
    def create_for_cache(component, action, options = {})
      timestamp = Time.now.to_i
      action_code = PATTERNS[:action][action] || PATTERNS[:action][:click]
      component_code = PATTERNS[:component][component] || PATTERNS[:component][:button]

      segments = [
        (timestamp & 0xFFFFFFFF).to_s(16).rjust(8, '0'),
        ((timestamp >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
        '7' + (action_code & 0xFFF).to_s(16).rjust(3, '0'),
        (component_code & 0xFFFF).to_s(16).rjust(4, '0'),
        SecureRandom.random_number(0xFFFFFFFFFFFF).to_s(16).rjust(12, '0'),
      ]
      segments.join('-')
    end

    # Generate UUID optimized for database indexing
    def create_for_index(component, action, timestamp = nil)
      timestamp ||= Time.now.to_i
      action_code = PATTERNS[:action][action] || PATTERNS[:action][:click]
      component_code = PATTERNS[:component][component] || PATTERNS[:component][:button]

      segments = [
        (timestamp & 0xFFFFFFFF).to_s(16).rjust(8, '0'),
        ((timestamp >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
        '6' + (action_code & 0xFFF).to_s(16).rjust(3, '0'),
        (component_code & 0xFFFF).to_s(16).rjust(4, '0'),
        SecureRandom.random_number(0xFFFFFFFFFFFF).to_s(16).rjust(12, '0'),
      ]
      segments.join('-')
    end

    # === UUID ANALYSIS ===

    # Extract all information from a UUID
    def analyze(uuid)
      return nil unless valid?(uuid)

      parts = uuid.split('-')
      timestamp = parts[0].to_i(16)

      {
        action: extract_action(parts),
        component: extract_component(parts),
        state: extract_state(parts),
        vortex_state: extract_vortex_state(parts),
        timestamp: timestamp,
        entropy: calculate_entropy(uuid),
        index_efficiency: calculate_index_efficiency(uuid),
        cache_efficiency: calculate_cache_efficiency(uuid),
        is_void: void?(uuid),
      }
    end

    # Extract action from UUID parts
    def extract_action(parts)
      action_code = parts[2][1..3].to_i(16)
      PATTERNS[:action].key(action_code) || :click
    end

    # Extract component from UUID parts
    def extract_component(parts)
      component_code = parts[3].to_i(16)
      PATTERNS[:component].key(component_code) || :button
    end

    # Extract state from UUID parts
    def extract_state(parts)
      state_vortex_code = parts[4].to_i(16)
      state_code = state_vortex_code & 0xF000
      PATTERNS[:state].key(state_code) || :active
    end

    # Extract vortex state from UUID parts
    def extract_vortex_state(parts)
      state_vortex_code = parts[4].to_i(16)
      vortex_code = state_vortex_code & 0x6000
      PATTERNS[:vortex].key(vortex_code) || :flowing
    end

    # === UUID TRANSFORMATION ===

    # Transform UUID by applying vortex effect
    def transform_by_vortex(uuid, vortex_state)
      return uuid unless valid?(uuid)

      parts = uuid.split('-')
      timestamp = parts[0].to_i(16)
      seed = uuid.hash

      case vortex_state
      when :consciousness
        seed = "#{uuid}#{vortex_state}".hash
        [
          (timestamp & 0xFFFFFFFF).to_s(16).rjust(8, '0'),
          ((seed >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
          '5' + ((seed >> 48) & 0xFFF).to_s(16).rjust(3, '0'),
          ((seed >> 60) & 0xFFFF).to_s(16).rjust(4, '0'),
          (seed & 0xFFFFFFFFFFFF).to_s(16).rjust(12, '0'),
        ].join('-')
      when :flowing
        [
          (timestamp & 0xFFFFFFFF).to_s(16).rjust(8, '0'),
          ((timestamp >> 32) & 0xFFFF).to_s(16).rjust(4, '0'),
          '6' + ((seed >> 48) & 0xFFF).to_s(16).rjust(3, '0'),
          ((seed >> 60) & 0xFFFF).to_s(16).rjust(4, '0'),
          SecureRandom.random_number(0xFFFFFFFFFFFF).to_s(16).rjust(12, '0'),
        ].join('-')
      when :vortex
        SecureRandom.uuid
      else
        uuid
      end
    end

    # Transform any UUID back to void
    def transform_to_void(uuid)
      create_void
    end

    # === VALIDATION ===

    # Check if UUID format is valid
    def valid?(uuid)
      uuid.match?(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i)
    end

    # Check if UUID is void
    def void?(uuid)
      uuid == create_void
    end

    # === EFFICIENCY CALCULATIONS ===

    # Calculate index efficiency (0.0 to 1.0)
    def calculate_index_efficiency(uuid)
      return 0.0 unless valid?(uuid)
      parts = uuid.split('-')
      version = parts[2][0].to_i
      case version
      when 6, 7
        0.9  # High efficiency for time-ordered UUIDs
      else
        0.6  # Lower efficiency for random UUIDs
      end
    end

    # Calculate cache efficiency (0.0 to 1.0)
    def calculate_cache_efficiency(uuid)
      return 0.0 unless valid?(uuid)
      parts = uuid.split('-')
      version = parts[2][0].to_i
      case version
      when 7
        0.95  # High efficiency for cache UUIDs
      when 6
        0.85  # Good efficiency for index UUIDs
      else
        0.7   # Lower efficiency for random UUIDs
      end
    end

    # Calculate entropy (0.0 to 1.0)
    def calculate_entropy(uuid)
      return 0.0 unless valid?(uuid)
      parts = uuid.split('-')
      version = parts[2][0].to_i
      case version
      when 5
        0.3   # Low entropy for deterministic UUIDs
      when 6
        0.6   # Medium entropy for time-ordered UUIDs
      when 7
        0.8   # High entropy for cache UUIDs
      else
        1.0   # Maximum entropy for random UUIDs
      end
    end

    # === BACKWARD COMPATIBILITY ===

    # Legacy method names for backward compatibility
    def generate_void_uuid(context = {})
      create_void
    end

    def void_uuid?(uuid)
      void?(uuid)
    end

    def emerge_from_void(context = {})
      create_from_void(context)
    end

    def generate_stimulus_uuid(context = {})
      create_with_patterns(context)
    end

    def generate_stimulus_cache_uuid(component, action, options = {})
      create_for_cache(component, action, options)
    end

    def generate_stimulus_index_uuid(component, action, timestamp = nil)
      create_for_index(component, action, timestamp)
    end

    def decode_stimulus_patterns(uuid)
      analyze(uuid)
    end

    def decode_action(parts)
      extract_action(parts)
    end

    def decode_component(parts)
      extract_component(parts)
    end

    def decode_state(parts)
      extract_state(parts)
    end

    def decode_vortex_state(parts)
      extract_vortex_state(parts)
    end

    def apply_stimulus_vortex(uuid, vortex_state)
      transform_by_vortex(uuid, vortex_state)
    end

    def valid_uuid_format?(uuid)
      valid?(uuid)
    end
  end

  # DEPRECATED: UuidMatrix is now an alias for UUID for backward compatibility
  UuidMatrix = UUID
end
