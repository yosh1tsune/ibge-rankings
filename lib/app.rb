require_relative 'models/state.rb'
require_relative 'models/city.rb'
require_relative 'services/rankings/state_rankings_service.rb'
require_relative 'services/rankings/names_by_decade_service.rb'
require_relative 'services/rankings/city_rankings_service.rb'

class App
  def execute
    input = nil
    puts "Bem vindo(a) ao buscador de frequência de nomes no Brasil!"

    while input != '4' do
      puts "\nEscolha uma das seguintes opções:\n
      1 - Rankings por UF
      2 - Rankings por cidade
      3 - Frequencia de um nome por década
      4 - Sair\n\n"
      input = $stdin.gets.chomp

      if input == '1'
        state_rankings
      elsif input == '2'
        city_rankings
      elsif input == '3'
        decade
      end
    end
    puts "\nAdios!"
  end

  def state_rankings
    State.all.map(&:print)
    uf = nil
    while uf != 'ok'
      puts "\nDigite a sigla de um Estado para ver os rankings ou 'ok' para retornar:\n\n"
      uf = $stdin.gets.chomp.upcase
      break if uf == 'OK'

      puts Rankings::StateRankingsService.new(state_acronym: uf).execute
    end
  end

  def city_rankings
    State.all.map(&:print)
    local = nil
    while local != 'ok'
      puts "\nDigite uma cidade (com acentos) e a sigla de sua UF, separados "\
          "por virgula (Ex: São Paulo, SP), para ver os rankings ou 'ok' para retornar:\n\n"
      local = $stdin.gets.chomp.upcase
      break if local == 'OK'

      puts Rankings::CityRankingsService.new(local: local).execute
    end
  end

  def decade
    names = nil
    while names != 'ok'
      puts "\nA base de dados do IBGE não leva em conta nomes compostos "\
          "(Ex: João Carlos), utilize apenas o primeiro nome.\n"\
          "Digite um ou mais nomes, separados por vírgula, para ver sua "\
          "frequência de uso por década ou 'ok' para retornar:\n\n"
      names = $stdin.gets.chomp.upcase
      break if names == 'OK'

      puts Rankings::NamesByDecadeService.new(names: names).execute
    end
  end
end
