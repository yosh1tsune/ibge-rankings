require 'byebug'
require 'csv'
require 'faraday'
require 'json'
require 'sqlite3'
require 'terminal-table'

class Estado
  @db = SQLite3::Database.new "test.db"
  
  def self.get_ufs
    response = @db.execute('SELECT * FROM estados ORDER BY nome')
    puts "\nUnidades Federativas do Brasil: \n\n"
    response.each do |uf|
      puts "#{uf[1]} " + '-' + " #{uf[2]}"
    end
    return response
  end

  def self.chama_rankings(sigla)
    uf = @db.execute("SELECT * FROM estados WHERE sigla = '#{sigla}'")
    return puts "\nUF não encontrada! Insira uma UF válida." if uf.empty?

    uf_geral(uf[0])
    uf_masc(uf[0])
    uf_fem(uf[0])
    return 'ok'
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
    montar_tabela("Ranking Geral: #{uf[2]}", rows)
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
    montar_tabela("Ranking Masculino: #{uf[2]}", rows)
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
    montar_tabela("Ranking Feminino: #{uf[2]}", rows)
  end

  def self.percentual_populacao(id, frequencia)
    csv = CSV.parse(File.read('./files/populacao_2019.csv'),headers: :first_row)
    populacao = csv.find{ |row| row['Cód.'] == "#{id}"}['População Residente -'\
                                                        ' 2019']
    populacao = (frequencia / populacao.to_f) * 100
  end

  def self.montar_tabela(ranking, rows)
    table = Terminal::Table.new :title => ranking, :headings => ['Posição', 
                                'Nome', 'Uso', 'Percentual na população'],
                                :rows => rows
    puts table
  end
end