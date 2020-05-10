def database_setup
  db = SQLite3::Database.new "test.db"
  db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS estados(
      id INT,
      nome VARCHAR(50),
      sigla VARCHAR(2)
    ); 
    CREATE TABLE IF NOT EXISTS cidades(
      id INT,
      nome VARCHAR(50),
      uf VARCHAR(2)
    );
  SQL
  setup_estados(db) if db.execute('SELECT * FROM estados').empty?
end

def setup_estados(db)
  puts 'Aguarde enquando o banco de dados é configurado :)'
  response = Faraday.get 'https://servicodados.ibge.gov.br/api/v1/localidades/estados'
  response = JSON.parse(response.body, symbolize_names: true)
  puts "Unidades Federativas do Brasil: \n\n"
  response.each do |uf|
    db.execute('INSERT INTO estados (id, nome, sigla) 
            VALUES (?, ?, ?)', ["#{uf[:id]}", "#{uf[:nome]}", "#{uf[:sigla]}"]
    )
  end
  puts 'Configuração completa! Hora da diversão :D'
end