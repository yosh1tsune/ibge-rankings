require_relative 'estado.rb'
require_relative 'cidade.rb'
require_relative 'decada.rb'
require_relative 'database_setup.rb'
require 'csv'

input = nil

database_setup

puts "\n\nBem vindo(a) ao buscador de frequência de nomes no Brasil!"

while input != '4' do
  puts "\nEscolha uma das seguintes opções: \n
        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair \n\n"
  input = $stdin.gets.chomp
  if input == '1'
    Estado.get_ufs
    uf = nil
    while uf != 'ok'
      puts "\nDigite a sigla de um Estado para ver os rankings ou 'ok' para retornar: \n\n"
      uf = $stdin.gets.chomp.upcase
      break if uf == 'OK'
      uf = Estado.chama_rankings(uf)
    end
  elsif input == '2'
    response = Estado.get_ufs
    puts "\nDigite uma cidade e a sigla de seu Estado, separados por virgula "\
         "(Ex: 'São Paulo, SP') para ver os rankings: \n\n"
    local = $stdin.gets.chomp.upcase
    Cidade.get_cidade(local)
  elsif input == '3'
    puts "\nDigite um ou mais nomes, separados por vírgula, para ver sua "\
         "frequência de uso por década: \n\n"
    nomes = $stdin.gets.chomp.upcase
    Decada.get_nomes(nomes)
  end
end

puts 'Adios!'