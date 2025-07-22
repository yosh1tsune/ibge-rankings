require 'faraday'
require 'json'

# Namespace for API-related request services.
module API
  # Abstract service for requesting name data from the IBGE API.
  # Subclasses must implement the {#url} method to specify the resource path for the request.
  #
  # @example
  #   class NameFrequencyService < API::NamesRequestService
  #     private
  #
  #     def url
  #       "#{ENDPOINT}?name=João"
  #     end
  #   end
  #
  #   service = NameFrequencyService.new
  #   service.execute # => [{ nome: "João", frequencia: ... }, ...]
  class NamesRequestService
    # Base URL for the IBGE names API endpoint.
    # @return [String] the base endpoint URL
    ENDPOINT = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes'

    # Executes the retrieval of name data from the IBGE API.
    #
    # @return [Array<Hash>] parsed response data with symbolized keys
    def execute
      response
    end

    private

    # Performs the HTTP GET request to the specified URL and parses the JSON response.
    #
    # @api private
    # @return [Array<Hash>] parsed JSON response data with symbolized keys
    def response
      data = Faraday.get(url)
      JSON.parse(data.body, symbolize_names: true)
    end

    # Returns the URL for the API request.
    #
    # @api private
    # @raise [NotImplementedError] if not implemented in subclass
    # @return [String] the full request URL
    def url
      raise NotImplementedError, 'You must implement the URL method in the subclass'
    end
  end
end
