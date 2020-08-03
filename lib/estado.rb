require 'byebug'
require 'csv'
require 'faraday'
require 'json'
require 'sqlite3'
require 'terminal-table'

class Estado
  attr_reader :estado
  
  def initialize(estado)
    @estado = estado
  end
  
  def self.all
    @db = SQLite3::Database.new "localidades.db"
    ufs = Array.new
    response = @db.execute('SELECT * FROM estados ORDER BY nome')
    ufs << "\nUnidades Federativas do Brasil: \n\n"
    response.each do |uf|
      ufs << "#{uf[1]} " + '-' + " #{uf[2]}"
    end
    return ufs
  end

  def uf_geral
    uf = seleciona_uf
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[:id]}"
    response = JSON.parse(response.body, symbolize_names: true)
    table = montar_tabela("Ranking Geral: #{uf[:sigla]}", uf, response)
  end

  def uf_masc
    uf = seleciona_uf
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[:id]}&sexo=M"
    response = JSON.parse(response.body, symbolize_names: true)
    table = montar_tabela("Ranking Masculino: #{uf[:sigla]}", uf, response)
  end

  def uf_fem
    uf = seleciona_uf
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[:id]}&sexo=F"
    response = JSON.parse(response.body, symbolize_names: true)
    table = montar_tabela("Ranking Feminino: #{uf[:sigla]}", uf, response)
  end

  def imprime_rankings
    puts uf_geral
    puts uf_fem
    puts uf_masc
  end

  private

  def seleciona_uf
    @db = SQLite3::Database.new "localidades.db"
    uf = @db.execute("SELECT * FROM estados WHERE sigla = '#{self.estado}'")
    return "\nUF não encontrada! Insira uma UF válida." if uf.empty?
    
    uf = {id: uf[0][0], nome: uf[0][1], sigla: uf[0][2]}
    return uf
  end

  def montar_tabela(title, uf, response)
    rows = []
    response[0][:res].each do |r|
      populacao = percentual_populacao(uf[:id], r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => title,
                                :headings => ['Posição', 'Nome', 'Uso', 
                                               'Percentual na população'],
                                :rows => rows
    return table
  end

  def percentual_populacao(id, frequencia)
    csv = CSV.parse(File.read('./files/populacao_2019.csv'),headers: :first_row)
    populacao = csv.find{ |row| row['Cód.'] == "#{id}"}['População Residente -'\
                                                        ' 2019']
    populacao = (frequencia / populacao.to_f) * 100
  end
end