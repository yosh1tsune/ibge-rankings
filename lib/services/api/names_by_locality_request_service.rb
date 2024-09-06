require_relative 'names_request_service.rb'

# API::NamesByLocalityRequestService
module API
  class NamesByLocalityRequestService < API::NamesRequestService

    private

    def response
      @response = Faraday.get("#{ENDPOINT}ranking/?localidade=#{locality_id}&#{options}")
      JSON.parse(@response.body, symbolize_names: true)
    end
  end
end
