require 'faraday'
require 'json'
require 'byebug'

sigla = nil
response = Faraday.get 'https://servicodados.ibge.gov.br/api/v1/localidades/estados'
response = JSON.parse(response.body, symbolize_names: true)

def get_ufs(response)
  puts 'Unidades Federativas do Brasil:'
  response.each do |uf|
    puts "#{uf[:nome]} " + '-' + " #{uf[:sigla]}"
  end
end

def ranking_uf_geral(uf)
  response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/nomes/ranking?localidade=#{uf[:id]}"
  response = JSON.parse(response.body, symbolize_names: true)
  puts "Ranking Geral: #{uf[:sigla]}"
  response[0][:res].each do |r|
    puts "#{r[:ranking]}. #{r[:nome]} - Frequência: #{r[:frequencia]}"
  end
end

get_ufs(response)

while sigla != 'q' do
  puts 'Digite a sigla de uma UF para ver os rankings: '
  puts "Digite 'q' para encerrar."
  sigla = gets.chomp
  uf = nil
  response.each do |r|
    uf = r if r[:sigla] == sigla
  end
  ranking_uf_geral(uf) if sigla != 'q'
end

puts 'Adios!'