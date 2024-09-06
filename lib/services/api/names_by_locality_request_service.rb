require_relative 'names_request_service.rb'

# API::NamesByLocalityRequestService
module API
  class NamesByLocalityRequestService < API::NamesRequestService
    attr_reader :locality_id, :options

    def initialize(locality_id:, options: nil)
      @locality_id = locality_id
      @options = options
    end

    private

    def response
      @response = Faraday.get("#{ENDPOINT}ranking/?localidade=#{locality_id}&#{options}")
      JSON.parse(@response.body, symbolize_names: true)
    end
  end
end
