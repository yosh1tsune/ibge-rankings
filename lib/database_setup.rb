def database_setup
  db = SQLite3::Database.new "test.db"
  db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS estados(
      id INT NOT NULL UNIQUE,
      nome VARCHAR(50) NOT NULL,
      sigla VARCHAR(2) NOT NULL
    );
  SQL
  db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS cidades(
      id INT NOT NULL UNIQUE,
      nome VARCHAR(50) NOT NULL,
      ufid INT,
      FOREIGN KEY(ufid) REFERENCES estados(id)
    );
  SQL
  puts 'Aguarde enquando o banco de dados é configurado :)'
  setup_estados(db) if db.execute('SELECT * FROM estados').empty?
  setup_cidades(db) if db.execute('SELECT * FROM cidades').empty?
  puts 'Tudo pronto! Hora da diversão :D'
end

def setup_estados(db)
  response = Faraday.get 'https://servicodados.ibge.gov.br/api/v1/localidades/estados'
  response = JSON.parse(response.body, symbolize_names: true)
  puts "Unidades Federativas do Brasil: \n\n"
  response.each do |uf|
    db.execute('INSERT INTO estados (id, nome, sigla) 
            VALUES (?, ?, ?)', ["#{uf[:id]}", "#{uf[:nome]}", "#{uf[:sigla]}"]
    )
  end
end

def setup_cidades(db)
  estados = db.execute('SELECT * FROM estados')
  estados.each do |estado|
    response = Faraday.get "https://servicodados.ibge.gov.br/api/v1/localidades/estados/#{estado[0]}/municipios"
    response = JSON.parse(response.body, symbolize_names: true)
    response.each do |cidade|
      db.execute('INSERT INTO cidades (id, nome, ufid) 
              VALUES (?, ?, ?)', ["#{cidade[:id]}", "#{cidade[:nome]}", "#{estado[0]}"]
      )
    end
  end
end