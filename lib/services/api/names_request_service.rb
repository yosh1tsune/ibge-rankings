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

    def response
      raise NotImplementedError.new("##{__method__.to_s} has to be implemented by children classes")
    end
  end
end
