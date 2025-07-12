require 'singleton'
require 'faraday'
require 'json'
require_relative '../../lib/models/state.rb'

class StatesSingleton
  include Singleton

  def initialize
    states
  end

  def states
    @states ||= states_api.map do |state|
      State.new(id: state[:id], name: state[:nome], acronym: state[:sigla])
    end
  end

  private

  def states_api
    @response ||= Faraday.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados')
    JSON.parse(@response.body, symbolize_names: true)
  rescue Faraday::ConnectionFailed
    retry
  end
end
