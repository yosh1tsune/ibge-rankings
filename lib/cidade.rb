require 'byebug'
require 'faraday'
require 'json'
require 'sqlite3'

$db = SQLite3::Database.new "test.db"

class Cidade
  def self.uf_geral(local)
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v1/localidades/estados/35/municipios"
    response = JSON.parse(response.body, symbolize_names: true)
    puts "\nRanking Geral: #{uf[2]} \n\n"
    response[0][:res].each do |r|
      puts "#{r[:ranking]}. #{r[:nome]} - Frequência: #{r[:frequencia]}"
    end
  end
end