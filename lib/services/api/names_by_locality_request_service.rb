require_relative 'names_request_service.rb'

# API::NamesByLocalityRequestService
module API
  class NamesByLocalityRequestService < API::NamesRequestService
    attr_reader :locality, :options

    def initialize(locality:, options: nil)
      @locality = locality
      @options = options
    end

    private

    def response
      @response = Faraday.get("#{ENDPOINT}/ranking/?localidade=#{locality.id}&#{options}")
      JSON.parse(@response.body, symbolize_names: true)
    end
  end
end
