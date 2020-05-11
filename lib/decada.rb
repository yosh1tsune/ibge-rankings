require 'byebug'
require 'faraday'
require 'json'
require 'terminal-table'

class Decada
  def self.get_nomes(nomes)
    nomes = nomes.split(',')
    i = 0
    while i < nomes.length 
      nomes[i] = nomes[i].rstrip.lstrip
      i += 1
    end
    nomes_por_decada(nomes)
  end

  def self.nomes_por_decada(nomes)
    rows = [['1930'], ['1930 - 1940'], ['1940 - 1950'], ['1950 - 1960'],
           ['1960 - 1970'], ['1970 - 1980'], ['1980 - 1990'], ['1990 - 2000'],
           ['2000 - 2010']]
    nomes.each do |n|
      response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/nomes/#{n}?decada"
      response = JSON.parse(response.body, symbolize_names: true)
      response[0][:res].each_with_index do |r, index|
        rows[index] << r[:frequencia]
      end
    end
    nomes.insert(0, 'Década')
    table = Terminal::Table.new :title => "Frequência de uso por década", :headings => nomes, :rows => rows
    puts table
  end
end