require 'faraday'
require 'json'

module API
  class NamesRequestService
    attr_reader :locality_id, :options

    ENDPOINT = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking/'

    def initialize(locality_id:, options: nil)
      @locality_id = locality_id
      @options = options
    end

    def execute
      response
    end

    private

    def response
      @response = Faraday.get("#{ENDPOINT}?localidade=#{locality_id}&#{options}")
      JSON.parse(@response.body, symbolize_names: true)
    end
  end
end
