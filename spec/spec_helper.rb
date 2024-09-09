require 'vcr'

require_relative '../lib/models/city'
require_relative '../lib/models/state'
require_relative '../lib/services/api/names_by_decade_request_service'
require_relative '../lib/services/api/names_by_locality_request_service'
require_relative '../lib/services/calculators/population_percentage_calculator'
require_relative '../lib/services/rankings/city_rankings_service'
require_relative '../lib/services/rankings/names_by_decade_service'
require_relative '../lib/services/rankings/state_rankings_service'

RSpec.configure do |config|
  VCR.configure do |config|
    config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
    config.hook_into :faraday
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
