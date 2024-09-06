require 'faraday'
require 'json'

# API::NamesRequestService
module API
  class NamesRequestService
    attr_reader :locality_id, :options

    ENDPOINT = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes/'

    def initialize(locality_id:, options: nil)
      @locality_id = locality_id
      @options = options
    end

    def execute
      response
    end

    private

    def response; end
  end
end
