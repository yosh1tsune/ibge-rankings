require 'csv'
require 'faraday'
require 'json'
require 'terminal-table'
require_relative '../config/initializers/state_singleton.rb'

class Estado
  attr_reader :id, :name, :acronym

  def self.all
    StateSingleton.instance.states
  end

  def self.find(acronym)
    all.select {|state| state.acronym == acronym }.first
  end

  def initialize(id:, name:, acronym:)
    @id = id
    @name = name
    @acronym = acronym
  end

  def print
    puts "#{name} - #{acronym}"
  end

  def uf_geral
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{id}"
    response = JSON.parse(response.body, symbolize_names: true)
    table = montar_tabela("Ranking Geral: #{acronym}", response)
  end

  def uf_masc
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{id}&sexo=M"
    response = JSON.parse(response.body, symbolize_names: true)
    table = montar_tabela("Ranking Masculino: #{acronym}", response)
  end

  def uf_fem
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{id}&sexo=F"
    response = JSON.parse(response.body, symbolize_names: true)
    table = montar_tabela("Ranking Feminino: #{acronym}", response)
  end

  def imprime_rankings
    puts uf_geral
    puts uf_fem
    puts uf_masc
  end

  private

  def montar_tabela(title, response)
    rows = []
    response[0][:res].each do |r|
      populacao = percentual_populacao(id, r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => title,
                                :headings => ['Posição', 'Nome', 'Uso',
                                               'Percentual na população'],
                                :rows => rows
    return table
  end

  def percentual_populacao(id, frequencia)
    csv = CSV.parse(File.read('./spec/support/populacao_2019.csv'),headers: :first_row)
    populacao = csv.find{ |row| row['Cód.'] == "#{id}"}['População Residente -'\
                                                        ' 2019']
    populacao = (frequencia / populacao.to_f) * 100
  end
end