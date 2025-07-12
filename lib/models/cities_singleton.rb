require 'singleton'
require 'faraday'
require 'json'
require_relative 'states_singleton.rb'
require_relative '../../lib/models/city.rb'

class CitiesSingleton
  include Singleton

  def initialize
    cities
  end

  def cities
    @cities ||= cities_api.flatten.map do |city|
      City.new(id: city[:id], name: city[:nome], state_acronym: city[:'regiao-imediata'][:'regiao-intermediaria'][:UF][:sigla])
    end
  end

  private

  def cities_api
    @cities_response ||= StatesSingleton.instance.states.map do |state|
      response = Faraday.get("https://servicodados.ibge.gov.br/api/v1/localidades/estados/#{state.id}/municipios")
      JSON.parse(response.body, symbolize_names: true)
    end
  rescue Faraday::ConnectionFailed
    retry
  end
end
