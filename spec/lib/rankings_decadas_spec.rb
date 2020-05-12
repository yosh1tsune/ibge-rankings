require 'decada'

describe 'Rankings decadas' do
  it 'mostra o uso de um nome ao longo das decadas' do
    allow($stdin).to receive(:gets).and_return('3', 'bruno', '4')
    expect { load './lib/app.rb' }.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


A base de dados do IBGE não leva em conta nomes compostos (Ex: João Carlos), utilize apenas o primeiro nome.
Digite um ou mais nomes, separados por vírgula, para ver sua frequência de uso por década ou 'ok' para retornar: 

+---------------+--------------+
| Frequência de uso por década |
+---------------+--------------+
| Década        | BRUNO        |
+---------------+--------------+
| 1930          | 599          |
| 1930 - 1940   | 1351         |
| 1940 - 1950   | 2071         |
| 1950 - 1960   | 2595         |
| 1960 - 1970   | 4080         |
| 1970 - 1980   | 17911        |
| 1980 - 1990   | 172313       |
| 1990 - 2000   | 291524       |
| 2000 - 2010   | 175773       |
+---------------+--------------+

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout    
  end

  it 'ou mostra o uso de mais de um nome ao longo das decadas' do
    allow($stdin).to receive(:gets).and_return('3', 'bruno, felipe', '4')
    expect { load './lib/app.rb' }.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


A base de dados do IBGE não leva em conta nomes compostos (Ex: João Carlos), utilize apenas o primeiro nome.
Digite um ou mais nomes, separados por vírgula, para ver sua frequência de uso por década ou 'ok' para retornar: 

+-------------+--------+--------+
| Frequência de uso por década  |
+-------------+--------+--------+
| Década      | BRUNO  | FELIPE |
+-------------+--------+--------+
| 1930        | 599    | 600    |
| 1930 - 1940 | 1351   | 1173   |
| 1940 - 1950 | 2071   | 1750   |
| 1950 - 1960 | 2595   | 2462   |
| 1960 - 1970 | 4080   | 3719   |
| 1970 - 1980 | 17911  | 12447  |
| 1980 - 1990 | 172313 | 107869 |
| 1990 - 2000 | 291524 | 263480 |
| 2000 - 2010 | 175773 | 227960 |
+-------------+--------+--------+

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout    
  end

  it 'ou pede nova inserção caso o nome não seja encontrado' do
    allow($stdin).to receive(:gets).and_return('3', 'dnekjndkjnef', 'ok', '4')
    expect { load './lib/app.rb' }.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


A base de dados do IBGE não leva em conta nomes compostos (Ex: João Carlos), utilize apenas o primeiro nome.
Digite um ou mais nomes, separados por vírgula, para ver sua frequência de uso por década ou 'ok' para retornar: 


Nome DNEKJNDKJNEF não encontrado! Verifique a ortografia e as instruções

A base de dados do IBGE não leva em conta nomes compostos (Ex: João Carlos), utilize apenas o primeiro nome.
Digite um ou mais nomes, separados por vírgula, para ver sua frequência de uso por década ou 'ok' para retornar: 


Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout
  end

  it "ou retorna 'não encontrado' apenas para nomes compostos" do
    allow($stdin).to receive(:gets).and_return('3', 
                                        'bruno felipe, bruno, joao carlos', '4')
    expect{ load './lib/app.rb' }.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


A base de dados do IBGE não leva em conta nomes compostos (Ex: João Carlos), utilize apenas o primeiro nome.
Digite um ou mais nomes, separados por vírgula, para ver sua frequência de uso por década ou 'ok' para retornar: 


Nome BRUNO FELIPE não encontrado! Verifique a ortografia e as instruções

Nome JOAO CARLOS não encontrado! Verifique a ortografia e as instruções
+---------------+--------------+
| Frequência de uso por década |
+---------------+--------------+
| Década        | BRUNO        |
+---------------+--------------+
| 1930          | 599          |
| 1930 - 1940   | 1351         |
| 1940 - 1950   | 2071         |
| 1950 - 1960   | 2595         |
| 1960 - 1970   | 4080         |
| 1970 - 1980   | 17911        |
| 1980 - 1990   | 172313       |
| 1990 - 2000   | 291524       |
| 2000 - 2010   | 175773       |
+---------------+--------------+

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout
  end

  it 'ou retorna para o inicio sem consultar' do
    allow($stdin).to receive(:gets).and_return('3', 'ok', '4')
    expect { load './lib/app.rb' }.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


A base de dados do IBGE não leva em conta nomes compostos (Ex: João Carlos), utilize apenas o primeiro nome.
Digite um ou mais nomes, separados por vírgula, para ver sua frequência de uso por década ou 'ok' para retornar: 


Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout
  end
end