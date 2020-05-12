require 'byebug'
require 'csv'
require 'faraday'
require 'json'
require 'sqlite3'
require 'terminal-table'

class Cidade
  @db = SQLite3::Database.new "test.db"
  puts "Estatísticas por Cidade: \n\n"
  def self.get_cidade(local)
    cidade = local.split(',')[0].delete(',').lstrip.rstrip
    uf = local.split(',')[1].lstrip.rstrip
    ufid = @db.execute("SELECT * FROM estados WHERE sigla = '#{uf}'")
    local = @db.execute("SELECT * FROM cidades WHERE nome = '#{cidade}' "\
                        "AND ufid = '#{ufid[0][0]}'")
    cidade_geral(local, uf)
    cidade_masculino(local, uf)
    cidade_feminino(local, uf)
  end

  def self.cidade_geral(local, uf)
    rows = []
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{local[0][0]}"
    response = JSON.parse(response.body, symbolize_names: true)
    response[0][:res].each do |r|
      populacao = percentual_populacao(local[0][0], r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => "Ranking Geral: #{local[0][1]}, #{uf}", 
                                :headings => ['Posição', 'Nome', 'Uso',
                                              'Percentual na população'],
                                :rows => rows
    puts table
  end

  def self.cidade_masculino(local, uf)
    rows = []
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{local[0][0]}&sexo=M"
    response = JSON.parse(response.body, symbolize_names: true)
    response[0][:res].each do |r|
      populacao = percentual_populacao(local[0][0], r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => "Ranking Masculino: #{local[0][1]}, #{uf}", 
                                :headings => ['Posição', 'Nome', 'Uso',
                                              'Percentual na população'],
                                :rows => rows
    puts table
  end

  def self.cidade_feminino(local, uf)
    rows = []
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{local[0][0]}&sexo=F"
    response = JSON.parse(response.body, symbolize_names: true)
    response[0][:res].each do |r|
      populacao = percentual_populacao(local[0][0], r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => "Ranking Feminino: #{local[0][1]}, #{uf}", 
                                :headings => ['Posição', 'Nome', 'Uso',
                                              'Percentual na população'],
                                :rows => rows
    puts table
  end

  def self.percentual_populacao(id, frequencia)
    csv = CSV.parse(File.read('./files/populacao_2019.csv'),headers: :first_row)
    populacao = csv.find{ |row| row['Cód.'] == "#{id}"}['População Residente - 2019']
    populacao = (frequencia / populacao.to_f) * 100
  end
end