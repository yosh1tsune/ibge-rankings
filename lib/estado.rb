require 'byebug'
require 'faraday'
require 'json'
require 'sqlite3'

class Estado
  @db = SQLite3::Database.new "test.db"
  
  def self.get_ufs
    response = @db.execute('SELECT * FROM estados')
    puts "\nUnidades Federativas do Brasil: \n\n"
    response.each do |uf|
      puts "#{uf[1]} " + '-' + " #{uf[2]}"
    end
    return response
  end

  def self.uf_geral(uf)
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[0]}"
    response = JSON.parse(response.body, symbolize_names: true)
    puts "\nRanking Geral: #{uf[2]} \n\n"
    response[0][:res].each do |r|
      puts "#{r[:ranking]}. #{r[:nome]} - Frequência: #{r[:frequencia]}"
    end
  end

  def self.uf_masc(uf)
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[0]}&sexo=M"
    response = JSON.parse(response.body, symbolize_names: true)
    puts "\nRanking Masculino: #{uf[2]} \n\n"
    response[0][:res].each do |r|
      puts "#{r[:ranking]}. #{r[:nome]} - Frequência: #{r[:frequencia]}"
    end
  end

  def self.uf_fem(uf)
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[0]}&sexo=F"
    response = JSON.parse(response.body, symbolize_names: true)
    puts "\nRanking Feminino: #{uf[2]} \n\n"
    response[0][:res].each do |r|
      puts "#{r[:ranking]}. #{r[:nome]} - Frequência: #{r[:frequencia]}"
    end
  end
end