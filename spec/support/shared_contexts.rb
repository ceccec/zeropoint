# frozen_string_literal: true

# Shared RSpec Contexts for DRY, reusable setup/teardown logic

RSpec.shared_context 'with zeropoint setup' do
  before do
    TestHelpers::RailsMocks.setup_rails_mocks
    TestHelpers::TimeMocks.setup_time_mocks
    TestHelpers::ModelMocks.setup_model_mocks
    TestHelpers::ZeropointMocks.setup_zeropoint_mocks
  end
end

RSpec.shared_context 'with cache setup' do
  let(:cache) { Zeropoint::Cache::RedisCache.new }
  let(:cache_data) { TestHelpers::TestData.sample_cache_data }
end

RSpec.shared_context 'with vortex setup' do
  let(:vortex_stream) { Zeropoint::Vortex::Stream.new(User, filters: { active: true }) }
  let(:vortex_data) { TestHelpers::TestData.sample_vortex_data }
end

RSpec.shared_context 'with search setup' do
  let(:search_service) { Zeropoint::GraphqlUiLayout::Services::SearchStrategyService.new(User, 'test') }
  let(:query_builder) { Zeropoint::GraphqlUiLayout::Services::QueryBuilderService.new(User.all) }
end 