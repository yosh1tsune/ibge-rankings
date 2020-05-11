require 'byebug'
require 'faraday'
require 'json'
require 'sqlite3'

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
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{local[0][0]}"
    response = JSON.parse(response.body, symbolize_names: true)
    puts "\nRanking Geral: #{local[0][1]}, #{uf} \n\n"
    response[0][:res].each do |r|
      puts "#{r[:ranking]}. #{r[:nome]} - Frequência: #{r[:frequencia]}"
    end
  end

  def self.cidade_masculino(local, uf)
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{local[0][0]}&sexo=M"
    response = JSON.parse(response.body, symbolize_names: true)
    puts "\nRanking Geral: #{local[0][1]}, #{uf} \n\n"
    response[0][:res].each do |r|
      puts "#{r[:ranking]}. #{r[:nome]} - Frequência: #{r[:frequencia]}"
    end
  end

  def self.cidade_feminino(local, uf)
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{local[0][0]}&sexo=F"
    response = JSON.parse(response.body, symbolize_names: true)
    puts "\nRanking Geral: #{local[0][1]}, #{uf} \n\n"
    response[0][:res].each do |r|
      puts "#{r[:ranking]}. #{r[:nome]} - Frequência: #{r[:frequencia]}"
    end
  end
end