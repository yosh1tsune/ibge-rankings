require 'faraday'
require 'json'
require 'terminal-table'

class Decada
  attr_reader :nomes

  def initialize(nomes)
    @nomes = formata_nomes(nomes)
  end

  def nomes_por_decada
    erros = []
    dados = []
    response = Faraday.new
    self.nomes.each do |n|
      response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                             "nomes/#{n.delete(' ')}?decada"
      dados << JSON.parse(response.body, symbolize_names: true)
      erros << "\nNome #{n} não encontrado! Verifique a ortografia e as "\
               "instruções" if dados.empty?
    end
    return erros if !erros.empty?

    monta_tabela(self.nomes, dados)
  end

  private

  def formata_nomes(nomes)
    nomes = nomes.split(',')
    i = 0
    while i < nomes.length
      nomes[i] = nomes[i].rstrip.lstrip
      i += 1
    end
    return nomes
  end

  def monta_tabela(nomes, dados)
    rows = [['1930['], ['[1930,1940['], ['[1940,1950['], ['[1950,1960['],
           ['[1960,1970['], ['[1970,1980['], ['[1980,1990['], ['[1990,2000['],
           ['[2000,2010[']]
    title = ''
    headers = ['Década']
    nomes.each_with_index do |n, index|
      dados[index][0][:res].each do |r|
        rows.each do |row|
          row << r[:frequencia] if row.include?(r[:periodo])
        end
      end
      title == '' ? title = n : title = "#{title}, " + n
      headers << n
    end
    table = Terminal::Table.new :title => "Frequência de uso por década: #{title}",
                                :headings => headers, :rows => rows
    return table
  end
end
