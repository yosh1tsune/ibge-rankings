require 'byebug'
require 'csv'
require 'faraday'
require 'json'
require 'sqlite3'
require 'terminal-table'

class Cidade
  attr_reader :cidade, :uf

  def initialize(cidade)
    @cidade = cidade.split(',')[0].delete(',').lstrip.rstrip
    @uf = cidade.split(',')[1].lstrip.rstrip if cidade.split(',')[1] != nil
  end

  def cidade_geral
    cidade = seleciona_cidade
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{cidade[:id]}"
    response = JSON.parse(response.body, symbolize_names: true)
    monta_tabela("Ranking Geral: #{cidade[:nome]}, #{cidade[:uf]}", cidade,
                 response)
  end

  def cidade_masc
    cidade = seleciona_cidade
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{cidade[:id]}&sexo=M"
    response = JSON.parse(response.body, symbolize_names: true)
    monta_tabela("Ranking Masculino: #{cidade[:nome]}, #{cidade[:uf]}",
                 cidade, response)
  end

  def cidade_fem
    cidade = seleciona_cidade
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v2/censos/"\
                           "nomes/ranking?localidade=#{cidade[:id]}&sexo=F"
    response = JSON.parse(response.body, symbolize_names: true)
    monta_tabela("Ranking Feminino: #{cidade[:nome]}, #{cidade[:uf]}",
                 cidade, response)
  end

  def imprime_rankings
    puts cidade_geral
    puts cidade_fem
    puts cidade_masc
  end

  private

  def seleciona_cidade
    @db = SQLite3::Database.new "localidades.db"
    ufid = @db.execute("SELECT * FROM estados WHERE sigla = '#{self.uf}'")
    return "\nUF não encontrada. Certifique-se de que inseriu Cidade e "\
           'UF separados por vírgula!' if ufid.empty?

    local = @db.execute("SELECT * FROM cidades WHERE nome = '#{self.cidade}'"\
                        " AND ufid = '#{ufid[0][0]}'")
    return "\nCidade não encontrada. Certifique-se de que inseriu "\
           'o nome correto!' if local.empty?

    local = {id: local[0][0], nome: local[0][1], uf: self.uf}

    return local
  end

  def percentual_populacao(id, frequencia)
    csv = CSV.parse(File.read('./files/populacao_2019.csv'),headers: :first_row)
    populacao = csv.find{ |row| row['Cód.'] == "#{id}"}['População Residente -'\
                                                        ' 2019']
    populacao = (frequencia / populacao.to_f) * 100
  end

  def monta_tabela(title, cidade, response)
    rows = []
    response[0][:res].each do |r|
      populacao = percentual_populacao(cidade[:id], r[:frequencia])
      rows << [r[:ranking], r[:nome], r[:frequencia], "#{populacao.round(2)}%"]
    end
    table = Terminal::Table.new :title => title, :headings => ['Posição', 
                                'Nome', 'Uso', 'Percentual na população'],
                                :rows => rows
    return table
  end
end