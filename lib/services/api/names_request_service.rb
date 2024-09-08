require 'faraday'
require 'json'

# API::NamesRequestService
module API
  class NamesRequestService
    ENDPOINT = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes'

    def execute
      response
    end

    private

    def response; end
  end
end
