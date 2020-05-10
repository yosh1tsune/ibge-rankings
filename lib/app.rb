require_relative 'estados.rb'
require_relative 'database_setup.rb'

input = nil

database_setup
response = Estados.get_ufs

while input != '4' do
  puts "\nEscolha uma das seguintes opções: 1 - Rankings por UF, 2 - Rankings por cidade, 3 - Frequencia de um nome por década, 4 - Sair. \n\n"
  input = gets.chomp
  if input == '1'
    puts "\nDigite a sigla de uma UF para ver os rankings: \n\n"
    uf = gets.chomp
    response.each do |r|
      Estados.uf_geral(r) if r[2] == uf
      Estados.uf_masc(r) if r[2] == uf
      Estados.uf_fem(r) if r[2] == uf
    end
  elsif input == '2'
    puts 'lal'
  elsif input == '3'

  end
end

puts 'Adios!'