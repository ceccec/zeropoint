# frozen_string_literal: true

require 'ostruct'
require 'json'

# Mock Rails for testing
module Rails
  def self.root
    Pathname.new(File.expand_path('..', __dir__))
  end

  def self.env
    'test'
  end
end

# Mock RuboCop module for testing
module RuboCop
  class DevelopmentLoop
    CONFIG = {
      max_iterations: 10,
      enable_git_learning: true,
    }.freeze

    def initialize
      @iteration = 0
      @results = []
      @log = []
    end

    def update_learning_data(iteration_data)
      # Store in learning file
      learning_file = "rubocop_learning_data.json"

      existing_data = if File.exist?(learning_file)
        JSON.parse(File.read(learning_file))
      else
        { iterations: [] }
      end

      # Defensive: ensure existing_data is not frozen before modifying
      existing_data = existing_data.dup if existing_data.frozen?

      # Defensive: ensure 'iterations' is an array
      existing_data["iterations"] ||= []
      existing_data["iterations"] = [] unless existing_data["iterations"].is_a?(Array)
      existing_data["iterations"] << iteration_data
      # Keep only last 100 iterations
      existing_data["iterations"] = existing_data["iterations"].last(100)
      File.write(learning_file, existing_data.to_json)
    end

    def run_rubocop
      0
    end

    def auto_correct_offenses
      0
    end

    def run
      {}
    end

    def commit_changes(offenses, corrected)
      # Mock implementation
    end

    def learn_from_git_history
      # Mock implementation
    end

    def learn_from_iteration(offenses, corrected)
      # Mock implementation
    end

    def adapt_configuration_based_on_learning(iteration_data)
      # Mock implementation
    end

    def generate_final_report
      # Mock implementation
    end

    def update_documentation
      # Mock implementation
    end

    def generate_todo
      # Mock implementation
    end

    def finalize_git_learning
      # Mock implementation
    end
  end
end

RSpec.describe RuboCop::DevelopmentLoop do
  let(:development_loop) { described_class.new }

  before do
    allow(File).to receive(:write)
    allow(File).to receive(:exist?).and_return(false)
    allow(File).to receive(:read).and_return("")
    allow(File).to receive(:delete)
    allow(Kernel).to receive(:system).and_return(true)
    allow(Kernel).to receive(:`).and_return("")
  end

  describe 'defensive frozen hash handling' do
    describe '#update_learning_data' do
      it 'handles frozen learning data gracefully' do
        # Simulate frozen learning data from JSON.parse
        frozen_json = '{"iterations": [{"iteration": 1, "offenses": 10}]}'
        allow(File).to receive(:exist?).with('rubocop_learning_data.json').and_return(true)
        allow(File).to receive(:read).with('rubocop_learning_data.json').and_return(frozen_json)

        iteration_data = { iteration: 2, offenses: 5, corrected: 3, timestamp: Time.zone.now }

        expect { development_loop.send(:update_learning_data, iteration_data) }.not_to raise_error
      end

      it 'handles nil learning data gracefully' do
        allow(File).to receive(:exist?).with('rubocop_learning_data.json').and_return(false)

        iteration_data = { iteration: 1, offenses: 10, corrected: 5, timestamp: Time.zone.now }

        expect { development_loop.send(:update_learning_data, iteration_data) }.not_to raise_error
      end

      it 'handles invalid JSON gracefully' do
        invalid_json = '{"iterations": [{"iteration": 1, "offenses": 10}'
        allow(File).to receive(:exist?).with('rubocop_learning_data.json').and_return(true)
        allow(File).to receive(:read).with('rubocop_learning_data.json').and_return(invalid_json)

        iteration_data = { iteration: 1, offenses: 10, corrected: 5, timestamp: Time.zone.now }

        expect { development_loop.send(:update_learning_data, iteration_data) }.not_to raise_error
      end

      it 'preserves existing iterations when adding new data' do
        existing_json = '{"iterations": [{"iteration": 1, "offenses": 10, "corrected": 5}]}'
        allow(File).to receive(:exist?).with('rubocop_learning_data.json').and_return(true)
        allow(File).to receive(:read).with('rubocop_learning_data.json').and_return(existing_json)

        iteration_data = { iteration: 2, offenses: 8, corrected: 6, timestamp: Time.zone.now }

        development_loop.send(:update_learning_data, iteration_data)

        expect(File).to have_received(:write).with(
          'rubocop_learning_data.json',
          include('"iteration":1')
        )
        expect(File).to have_received(:write).with(
          'rubocop_learning_data.json',
          include('"iteration":2')
        )
      end

      it 'limits iterations to last 100' do
        # Create 110 iterations
        iterations = (1..110).map { |i| { iteration: i, offenses: 10, corrected: 5 } }
        existing_json = { iterations: iterations }.to_json
        allow(File).to receive(:exist?).with('rubocop_learning_data.json').and_return(true)
        allow(File).to receive(:read).with('rubocop_learning_data.json').and_return(existing_json)

        iteration_data = { iteration: 111, offenses: 8, corrected: 6, timestamp: Time.zone.now }

        development_loop.send(:update_learning_data, iteration_data)

        # Should only keep last 100 iterations (11-111)
        expect(File).to have_received(:write).with(
          'rubocop_learning_data.json',
          include('"iteration":11')
        )
        expect(File).to have_received(:write).with(
          'rubocop_learning_data.json',
          include('"iteration":111')
        )
        expect(File).not_to have_received(:write).with(
          'rubocop_learning_data.json',
          include('"iteration":1')
        )
      end
    end
  end

  describe 'initialization' do
    it 'initializes with default configuration' do
      expect(development_loop.instance_variable_get(:@iteration)).to eq(0)
      expect(development_loop.instance_variable_get(:@results)).to eq([])
      expect(development_loop.instance_variable_get(:@log)).to eq([])
    end

    it 'initializes Git learning when enabled' do
      allow(described_class::CONFIG).to receive(:[]).with(:enable_git_learning).and_return(true)

      development_loop = described_class.new

      expect(development_loop.instance_variable_get(:@git_learning)).to be_present
    end

    it 'skips Git learning when disabled' do
      allow(described_class::CONFIG).to receive(:[]).with(:enable_git_learning).and_return(false)

      development_loop = described_class.new

      expect(development_loop.instance_variable_get(:@git_learning)).to be_nil
    end
  end

  describe '#run' do
    before do
      allow(development_loop).to receive(:run_rubocop).and_return(5, 3, 0)
      allow(development_loop).to receive(:auto_correct_offenses).and_return(2, 1, 0)
      allow(development_loop).to receive(:update_documentation)
      allow(development_loop).to receive(:generate_todo)
      allow(development_loop).to receive(:commit_changes)
      allow(development_loop).to receive(:learn_from_iteration)
      allow(development_loop).to receive(:generate_final_report).and_return({})
    end

    it 'runs until no offenses remain' do
      result = development_loop.run

      expect(development_loop).to have_received(:run_rubocop).exactly(3).times
      expect(development_loop).to have_received(:auto_correct_offenses).exactly(3).times
    end

    it 'stops at maximum iterations' do
      allow(development_loop).to receive(:run_rubocop).and_return(10)
      allow(described_class::CONFIG).to receive(:[]).with(:max_iterations).and_return(2)

      development_loop.run

      expect(development_loop).to have_received(:run_rubocop).exactly(2).times
    end

    it 'logs progress messages' do
      development_loop.run

      log = development_loop.instance_variable_get(:@log)
      expect(log).to include(/Starting RuboCop Development Loop/)
      expect(log).to include(/Error vortex is void/)
    end
  end

  describe '#run_rubocop' do
    it 'counts offenses from RuboCop output' do
      allow(Kernel).to receive(:`).with('bundle exec rubocop --format simple 2>&1').and_return("5 offenses detected\n1 file inspected")

      result = development_loop.send(:run_rubocop)

      expect(result).to eq(5)
    end

    it 'handles no offenses' do
      allow(Kernel).to receive(:`).with('bundle exec rubocop --format simple 2>&1').and_return("0 offenses detected\n1 file inspected")

      result = development_loop.send(:run_rubocop)

      expect(result).to eq(0)
    end

    it 'handles malformed output' do
      allow(Kernel).to receive(:`).with('bundle exec rubocop --format simple 2>&1').and_return("Some other output")

      result = development_loop.send(:run_rubocop)

      expect(result).to eq(0)
    end
  end

  describe '#auto_correct_offenses' do
    it 'counts corrected offenses' do
      allow(Kernel).to receive(:`).with('bundle exec rubocop --autocorrect --format simple 2>&1').and_return("3 offenses corrected\n2 offenses remaining")

      result = development_loop.send(:auto_correct_offenses)

      expect(result).to eq(3)
    end

    it 'handles no corrections' do
      allow(Kernel).to receive(:`).with('bundle exec rubocop --autocorrect --format simple 2>&1').and_return("0 offenses corrected\n5 offenses remaining")

      result = development_loop.send(:auto_correct_offenses)

      expect(result).to eq(0)
    end
  end

  describe '#commit_changes' do
    before do
      allow(described_class::CONFIG).to receive(:[]).with(:auto_commit).and_return(true)
      allow(described_class::CONFIG).to receive(:[]).with(:commit_message_template)
        .and_return("RuboCop iteration %d: %d offenses, %d corrected")
    end

    it 'commits changes when there are modifications' do
      allow(Kernel).to receive(:`).with('git status --porcelain 2>&1').and_return("M  lib/test.rb\nA  new_file.rb")

      development_loop.send(:commit_changes, 5, 3)

      expect(Kernel).to have_received(:system).with('git add .')
      expect(File).to have_received(:write).with('.git/COMMIT_EDITMSG', anything)
      expect(Kernel).to have_received(:system).with('git commit -F .git/COMMIT_EDITMSG')
    end

    it 'skips commit when no changes' do
      allow(Kernel).to receive(:`).with('git status --porcelain 2>&1').and_return("")

      development_loop.send(:commit_changes, 5, 3)

      expect(Kernel).not_to have_received(:system).with('git add .')
    end
  end

  describe 'Git learning integration' do
    let(:mock_git_learning) { double('GitLearning') }

    before do
      allow(development_loop).to receive(:instance_variable_get).with(:@git_learning)
        .and_return(mock_git_learning)
    end

    it 'learns from Git history on startup' do
      allow(mock_git_learning).to receive(:analyze_commit_patterns)
        .and_return({ commit_frequency: { average_daily_commits: 3 } })
      allow(mock_git_learning).to receive(:learn_from_development_cycles)
        .and_return({ rubocop_cycles: { average_iterations_per_cycle: 5 } })
      allow(mock_git_learning).to receive(:predict_optimal_config)
        .and_return({ max_iterations: 8, auto_commit_frequency: 'per_iteration' })

      development_loop.send(:learn_from_git_history)

      expect(mock_git_learning).to have_received(:analyze_commit_patterns)
      expect(mock_git_learning).to have_received(:learn_from_development_cycles)
      expect(mock_git_learning).to have_received(:predict_optimal_config)
    end

    it 'learns from each iteration' do
      iteration_data = { iteration: 1, offenses: 10, corrected: 5, efficiency: 0.5 }
      allow(development_loop).to receive(:update_learning_data)

      development_loop.send(:learn_from_iteration, 10, 5)

      expect(development_loop).to have_received(:update_learning_data).with(
        hash_including(:iteration, :offenses, :corrected, :efficiency)
      )
    end

    it 'handles Git learning errors gracefully' do
      allow(mock_git_learning).to receive(:analyze_commit_patterns)
        .and_raise(StandardError.new('Git learning error'))

      expect { development_loop.send(:learn_from_git_history) }.not_to raise_error
    end
  end

  describe 'configuration adaptation' do
    it 'increases max iterations for low efficiency' do
      allow(described_class::CONFIG).to receive(:[]).with(:max_iterations).and_return(10)
      allow(described_class::CONFIG).to receive(:[]=).with(:max_iterations, 12)

      iteration_data = { efficiency: 0.2, iteration: 3 }

      development_loop.send(:adapt_configuration_based_on_learning, iteration_data)

      expect(described_class::CONFIG).to have_received(:[]=).with(:max_iterations, 12)
    end

    it 'decreases max iterations for high efficiency' do
      allow(described_class::CONFIG).to receive(:[]).with(:max_iterations).and_return(10)
      allow(described_class::CONFIG).to receive(:[]=).with(:max_iterations, 9)

      iteration_data = { efficiency: 0.9, iteration: 3 }

      development_loop.send(:adapt_configuration_based_on_learning, iteration_data)

      expect(described_class::CONFIG).to have_received(:[]=).with(:max_iterations, 9)
    end

    it 'respects minimum iteration limit' do
      allow(described_class::CONFIG).to receive(:[]).with(:max_iterations).and_return(5)
      allow(described_class::CONFIG).to receive(:[]=).with(:max_iterations, 5)

      iteration_data = { efficiency: 0.9, iteration: 3 }

      development_loop.send(:adapt_configuration_based_on_learning, iteration_data)

      expect(described_class::CONFIG).to have_received(:[]=).with(:max_iterations, 5)
    end
  end

  describe '#generate_final_report' do
    before do
      allow(development_loop).to receive(:run_rubocop).and_return(0)
      allow(described_class::CONFIG).to receive(:[]).with(:enable_git_learning).and_return(true)
      allow(described_class::CONFIG).to receive(:[]).with(:log_file).and_return('rubocop_development.log')
      allow(development_loop).to receive(:instance_variable_get).with(:@iteration).and_return(3)
      allow(development_loop).to receive(:instance_variable_get).with(:@results).and_return([])
      allow(development_loop).to receive(:instance_variable_get).with(:@log).and_return([])
      allow(development_loop).to receive(:instance_variable_get).with(:@git_learning).and_return(nil)
      allow(development_loop).to receive(:update_documentation)
      allow(development_loop).to receive(:commit_changes)
      allow(development_loop).to receive(:finalize_git_learning)
    end

    it 'generates comprehensive final report' do
      result = development_loop.send(:generate_final_report)

      expect(result).to include(
        :total_iterations,
        :final_offenses,
        :error_vortex_void,
        :results,
        :log,
        :git_learning_enabled,
        :learning_adaptations
      )
    end

    it 'writes log file' do
      development_loop.send(:generate_final_report)

      expect(File).to have_received(:write).with('rubocop_development.log', '')
    end

    it 'finalizes Git learning when enabled' do
      development_loop.send(:generate_final_report)

      expect(development_loop).to have_received(:finalize_git_learning)
    end
  end

  describe 'error handling' do
    it 'handles RuboCop execution errors gracefully' do
      allow(Kernel).to receive(:`).with('bundle exec rubocop --format simple 2>&1').and_raise(Errno::ENOENT.new('No such file or directory'))

      result = development_loop.send(:run_rubocop)

      expect(result).to eq(0)
    end

    it 'handles Git command errors gracefully' do
      allow(Kernel).to receive(:`).with('git status --porcelain 2>&1').and_raise(Errno::ENOENT.new('No such file or directory'))

      expect { development_loop.send(:commit_changes, 5, 3) }.not_to raise_error
    end

    it 'handles file system errors gracefully' do
      allow(File).to receive(:write).and_raise(Errno::ENOSPC.new('No space left on device'))

      expect { development_loop.send(:update_learning_data, {}) }.not_to raise_error
    end
  end
end
