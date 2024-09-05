require_relative 'models/state.rb'
require_relative 'models/city.rb'
require_relative 'decada.rb'
require_relative 'services/rankings/state_rankings_service.rb'
require_relative 'services/rankings/city_rankings_service.rb'

input = nil

puts "\n\nBem vindo(a) ao buscador de frequência de nomes no Brasil!"

while input != '4' do
  puts "\nEscolha uma das seguintes opções: \n
        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair \n\n"
  input = $stdin.gets.chomp

  if input == '1'
    State.all.map(&:print)
    uf = nil
    while uf != 'ok'
      puts "\nDigite a sigla de um Estado para ver os rankings ou 'ok' para retornar: \n\n"
      uf = $stdin.gets.chomp.upcase
      break if uf == 'OK'

      Rankings::StateRankingsService.new(state_acronym: uf).execute
    end
  elsif input == '2'
    State.all.map(&:print)
    local = nil
    while local != 'ok'
      puts "\nDigite uma cidade (com acentos) e a sigla de sua UF, separados "\
           "por virgula (Ex: São Paulo, SP), para ver os rankings ou 'ok' para retornar:\n\n"
      local = $stdin.gets.chomp.upcase
      break if local == 'OK'

      Rankings::CityRankingsService.new(local: local).execute
    end
  elsif input == '3'
    nomes = nil
    while nomes != 'ok'
      puts "\nA base de dados do IBGE não leva em conta nomes compostos "\
          "(Ex: João Carlos), utilize apenas o primeiro nome.\n "\
          "Digite um ou mais nomes, separados por vírgula, para ver sua "\
          "frequência de uso por década ou 'ok' para retornar: \n\n"
      nomes = $stdin.gets.chomp.upcase
      break if nomes == 'OK'

      nomes = Decada.new(nomes)
      puts nomes.nomes_por_decada
    end
  end
end

puts "\nAdios!"
