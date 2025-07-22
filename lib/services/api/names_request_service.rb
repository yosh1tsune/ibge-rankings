require 'faraday'
require 'json'

# Módulo para serviços de requisição relacionados à API.
module API
  # Serviço abstrato para requisição de dados de nomes na API do IBGE.
  # Subclasses devem implementar o método {#url} para especificar o caminho de recurso da requisição.
  #
  # @example Exemplo de implementação
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
    # URL base do endpoint de nomes da API do IBGE.
    # @return [String] URL base do endpoint.
    ENDPOINT = 'https://servicodados.ibge.gov.br/api/v2/censos/nomes'

    # Executa a obtenção de dados de nomes da API do IBGE.
    #
    # @return [Array<Hash>] Dados de resposta analisados com chaves simbolizadas.
    def execute
      response
    end

    private

    # Realiza a requisição HTTP GET para a URL especificada e faz o parse da resposta JSON.
    #
    # @api private
    # @return [Array<Hash>] Dados JSON analisados com chaves simbolizadas.
    def response
      data = Faraday.get(url)
      JSON.parse(data.body, symbolize_names: true)
    end

    # Retorna a URL para a requisição à API.
    #
    # @api private
    # @raise [NotImplementedError] se não implementado na subclasse.
    # @return [String] URL completa de requisição.
    def url
      raise NotImplementedError, 'You must implement the URL method in the subclass'
    end
  end
end
