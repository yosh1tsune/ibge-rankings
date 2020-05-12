require 'byebug'
require 'csv'
require 'faraday'
require 'json'
require 'sqlite3'
require 'terminal-table'

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
    rows = []
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[0]}"
    response = JSON.parse(response.body, symbolize_names: true)
    response[0][:res].each do |r|
      populacao = percentual_populacao(uf[0], r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => "Ranking Geral: #{uf[2]}", 
                                :headings => ['Posição', 'Nome', 'Uso',
                                              'Percentual na população'],
                                :rows => rows
    puts table
  end

  def self.uf_masc(uf)
    rows = []
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[0]}&sexo=M"
    response = JSON.parse(response.body, symbolize_names: true)
    response[0][:res].each do |r|
      populacao = percentual_populacao(uf[0], r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => "Ranking Masculino: #{uf[2]}", 
                                :headings => ['Posição', 'Nome', 'Uso',
                                              'Percentual na população'],
                                :rows => rows
    puts table
  end

  def self.uf_fem(uf)
    rows = []
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{uf[0]}&sexo=F"
    response = JSON.parse(response.body, symbolize_names: true)
    response[0][:res].each do |r|
      populacao = percentual_populacao(uf[0], r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => "Ranking Feminino: #{uf[2]}", 
                                :headings => ['Posição', 'Nome', 'Uso',
                                              'Percentual na população'],
                                :rows => rows
    puts table
  end

  def self.percentual_populacao(id, frequencia)
    csv = CSV.parse(File.read('./files/populacao_2019.csv'),headers: :first_row)
    populacao = csv.find{ |row| row['Cód.'] == "#{id}"}['População Residente - 2019']
    populacao = (frequencia / populacao.to_f) * 100
  end
end