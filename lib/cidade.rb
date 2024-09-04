require 'byebug'
require 'csv'
require 'faraday'
require 'json'
require 'terminal-table'
require_relative '../config/initializers/state_singleton.rb'
require_relative '../config/initializers/city_singleton.rb'

class Cidade
  attr_reader :id, :name, :state_acronym

  def self.all
    CitySingleton.instance.cities
  end

  def self.find(local)
    @name = local.split(',')[0].delete(',').lstrip.rstrip
    @acronym = local.split(',')[1].lstrip.rstrip if local.split(',')[1] != nil

    all.select { |city| city.name.upcase == @name && city.state_acronym.upcase == @acronym }.first
  end

  def initialize(id:, name:, state_acronym:)
    @id = id
    @name = name
    @state_acronym = state_acronym
  end

  def cidade_geral
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{id}"
    response = JSON.parse(response.body, symbolize_names: true)
    monta_tabela("Ranking Geral: #{name}, #{state_acronym}", response)
  end

  def cidade_masc
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{id}&sexo=M"
    response = JSON.parse(response.body, symbolize_names: true)
    monta_tabela("Ranking Masculino: #{name}, #{state_acronym}", response)
  end

  def cidade_fem
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{id}&sexo=F"
    response = JSON.parse(response.body, symbolize_names: true)
    monta_tabela("Ranking Feminino: #{name}, #{state_acronym}", response)
  end

  def imprime_rankings
    puts cidade_geral
    puts cidade_fem
    puts cidade_masc
  end

  def state
    @state ||= StateSingleton.instance.states.select { |state| state.acronym == state_acronym }.first
  end

  private

  def percentual_populacao(frequencia)
    csv = CSV.parse(File.read('./spec/support/populacao_2019.csv'),headers: :first_row)
    populacao = csv.find{ |row| row['Cód.'] == "#{id}"}['População Residente -'\
                                                        ' 2019']
    populacao = (frequencia / populacao.to_f) * 100
  end

  def monta_tabela(title, response)
    rows = []
    response[0][:res].each do |r|
      populacao = percentual_populacao(r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => title, :headings => ['Posição',
                                'Nome', 'Uso', 'Percentual na população'],
                                :rows => rows
    return table
  end
end