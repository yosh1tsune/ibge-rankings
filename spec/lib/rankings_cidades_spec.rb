require 'cidade'

describe 'Rankings cidades' do
  it 'mostra com sucesso os rankings de uma cidade' do
    allow($stdin).to receive(:gets).and_return('2', 'são paulo, sp', '4')

    expect { load './lib/app.rb'}.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


Unidades Federativas do Brasil: 

Rondônia - RO
Acre - AC
Amazonas - AM
Roraima - RR
Pará - PA
Amapá - AP
Tocantins - TO
Maranhão - MA
Piauí - PI
Ceará - CE
Rio Grande do Norte - RN
Paraíba - PB
Pernambuco - PE
Alagoas - AL
Sergipe - SE
Bahia - BA
Minas Gerais - MG
Espírito Santo - ES
Rio de Janeiro - RJ
São Paulo - SP
Paraná - PR
Santa Catarina - SC
Rio Grande do Sul - RS
Mato Grosso do Sul - MS
Mato Grosso - MT
Goiás - GO
Distrito Federal - DF

Digite uma cidade (com acentos) e a sigla de sua UF, separados por virgula (Ex: São Paulo, SP), para ver os rankings ou 'ok' para retornar:

+---------+-----------+--------+-------------------------+
|              Ranking Geral: SÃO PAULO, SP              |
+---------+-----------+--------+-------------------------+
| Posição | Nome      | Uso    | Percentual na população |
+---------+-----------+--------+-------------------------+
| 1       | MARIA     | 580861 | 4.74%                   |
| 2       | JOSE      | 269471 | 2.2%                    |
| 3       | ANA       | 164192 | 1.34%                   |
| 4       | JOAO      | 129557 | 1.06%                   |
| 5       | ANTONIO   | 120942 | 0.99%                   |
| 6       | CARLOS    | 86583  | 0.71%                   |
| 7       | PAULO     | 83695  | 0.68%                   |
| 8       | LUCAS     | 74368  | 0.61%                   |
| 9       | GABRIEL   | 69770  | 0.57%                   |
| 10      | PEDRO     | 69003  | 0.56%                   |
| 11      | MARCOS    | 67821  | 0.55%                   |
| 12      | RAFAEL    | 65123  | 0.53%                   |
| 13      | LUIZ      | 64820  | 0.53%                   |
| 14      | FRANCISCO | 62311  | 0.51%                   |
| 15      | MARCELO   | 58532  | 0.48%                   |
| 16      | FELIPE    | 56902  | 0.46%                   |
| 17      | BRUNO     | 53391  | 0.44%                   |
| 18      | EDUARDO   | 52510  | 0.43%                   |
| 19      | RODRIGO   | 51761  | 0.42%                   |
| 20      | GUILHERME | 49372  | 0.4%                    |
+---------+-----------+--------+-------------------------+
+---------+-----------+--------+-------------------------+
|            Ranking Masculino: SÃO PAULO, SP            |
+---------+-----------+--------+-------------------------+
| Posição | Nome      | Uso    | Percentual na população |
+---------+-----------+--------+-------------------------+
| 1       | JOSE      | 268458 | 2.19%                   |
| 2       | JOAO      | 128977 | 1.05%                   |
| 3       | ANTONIO   | 120558 | 0.98%                   |
| 4       | CARLOS    | 86208  | 0.7%                    |
| 5       | PAULO     | 83312  | 0.68%                   |
| 6       | LUCAS     | 73550  | 0.6%                    |
| 7       | GABRIEL   | 68922  | 0.56%                   |
| 8       | PEDRO     | 68569  | 0.56%                   |
| 9       | MARCOS    | 67520  | 0.55%                   |
| 10      | LUIZ      | 64524  | 0.53%                   |
| 11      | RAFAEL    | 64514  | 0.53%                   |
| 12      | FRANCISCO | 62095  | 0.51%                   |
| 13      | MARCELO   | 58272  | 0.48%                   |
| 14      | FELIPE    | 56296  | 0.46%                   |
| 15      | BRUNO     | 52931  | 0.43%                   |
| 16      | EDUARDO   | 52194  | 0.43%                   |
| 17      | RODRIGO   | 51478  | 0.42%                   |
| 18      | GUILHERME | 48966  | 0.4%                    |
| 19      | LUIS      | 48799  | 0.4%                    |
| 20      | RICARDO   | 48579  | 0.4%                    |
+---------+-----------+--------+-------------------------+
+---------+----------+--------+-------------------------+
|            Ranking Feminino: SÃO PAULO, SP            |
+---------+----------+--------+-------------------------+
| Posição | Nome     | Uso    | Percentual na população |
+---------+----------+--------+-------------------------+
| 1       | MARIA    | 578712 | 4.72%                   |
| 2       | ANA      | 163620 | 1.34%                   |
| 3       | JULIANA  | 45103  | 0.37%                   |
| 4       | FERNANDA | 42818  | 0.35%                   |
| 5       | MARCIA   | 42567  | 0.35%                   |
| 6       | ADRIANA  | 41393  | 0.34%                   |
| 7       | PATRICIA | 40845  | 0.33%                   |
| 8       | CAMILA   | 38842  | 0.32%                   |
| 9       | SANDRA   | 38409  | 0.31%                   |
| 10      | JULIA    | 37080  | 0.3%                    |
| 11      | BEATRIZ  | 36865  | 0.3%                    |
| 12      | GABRIELA | 35404  | 0.29%                   |
| 13      | ALINE    | 34534  | 0.28%                   |
| 14      | BRUNA    | 33839  | 0.28%                   |
| 15      | RENATA   | 32525  | 0.27%                   |
| 16      | AMANDA   | 32068  | 0.26%                   |
| 17      | MARIANA  | 31960  | 0.26%                   |
| 18      | LETICIA  | 31663  | 0.26%                   |
| 19      | VANESSA  | 31357  | 0.26%                   |
| 20      | LUCIANA  | 31305  | 0.26%                   |
+---------+----------+--------+-------------------------+

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout
  end

  it 'ou nova inserção se cidade e uf não estiverem separadas por virgula' do
    allow($stdin).to receive(:gets).and_return('2', 'são paulo sp', 'ok', '4')

    expect { load './lib/app.rb'}.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


Unidades Federativas do Brasil: 

Rondônia - RO
Acre - AC
Amazonas - AM
Roraima - RR
Pará - PA
Amapá - AP
Tocantins - TO
Maranhão - MA
Piauí - PI
Ceará - CE
Rio Grande do Norte - RN
Paraíba - PB
Pernambuco - PE
Alagoas - AL
Sergipe - SE
Bahia - BA
Minas Gerais - MG
Espírito Santo - ES
Rio de Janeiro - RJ
São Paulo - SP
Paraná - PR
Santa Catarina - SC
Rio Grande do Sul - RS
Mato Grosso do Sul - MS
Mato Grosso - MT
Goiás - GO
Distrito Federal - DF

Digite uma cidade (com acentos) e a sigla de sua UF, separados por virgula (Ex: São Paulo, SP), para ver os rankings ou 'ok' para retornar:


UF não encontrada. Certifique-se de que inseriu Cidade e UF separados por vírgula!

Digite uma cidade (com acentos) e a sigla de sua UF, separados por virgula (Ex: São Paulo, SP), para ver os rankings ou 'ok' para retornar:


Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout
  end

  it 'ou nova inserção caso não encontre cidade' do
    allow($stdin).to receive(:gets).and_return('2', 'dkemkjndje, sp', 'ok', '4')

    expect { load './lib/app.rb'}.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


Unidades Federativas do Brasil: 

Rondônia - RO
Acre - AC
Amazonas - AM
Roraima - RR
Pará - PA
Amapá - AP
Tocantins - TO
Maranhão - MA
Piauí - PI
Ceará - CE
Rio Grande do Norte - RN
Paraíba - PB
Pernambuco - PE
Alagoas - AL
Sergipe - SE
Bahia - BA
Minas Gerais - MG
Espírito Santo - ES
Rio de Janeiro - RJ
São Paulo - SP
Paraná - PR
Santa Catarina - SC
Rio Grande do Sul - RS
Mato Grosso do Sul - MS
Mato Grosso - MT
Goiás - GO
Distrito Federal - DF

Digite uma cidade (com acentos) e a sigla de sua UF, separados por virgula (Ex: São Paulo, SP), para ver os rankings ou 'ok' para retornar:


Cidade não encontrada. Certifique-se de que inseriu o nome correto!

Digite uma cidade (com acentos) e a sigla de sua UF, separados por virgula (Ex: São Paulo, SP), para ver os rankings ou 'ok' para retornar:


Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout
  end

  it 'ou retorna para o inicio sem consultar' do
    allow($stdin).to receive(:gets).and_return('2', 'ok', '4')

    expect { load './lib/app.rb'}.to output(
"Aguarde enquando o banco de dados é configurado :)
Tudo pronto! Hora da diversão :D


Bem vindo(a) ao buscador de frequência de nomes no Brasil!

Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 


Unidades Federativas do Brasil: 

Rondônia - RO
Acre - AC
Amazonas - AM
Roraima - RR
Pará - PA
Amapá - AP
Tocantins - TO
Maranhão - MA
Piauí - PI
Ceará - CE
Rio Grande do Norte - RN
Paraíba - PB
Pernambuco - PE
Alagoas - AL
Sergipe - SE
Bahia - BA
Minas Gerais - MG
Espírito Santo - ES
Rio de Janeiro - RJ
São Paulo - SP
Paraná - PR
Santa Catarina - SC
Rio Grande do Sul - RS
Mato Grosso do Sul - MS
Mato Grosso - MT
Goiás - GO
Distrito Federal - DF

Digite uma cidade (com acentos) e a sigla de sua UF, separados por virgula (Ex: São Paulo, SP), para ver os rankings ou 'ok' para retornar:


Escolha uma das seguintes opções: 

        1 - Rankings por UF
        2 - Rankings por cidade
        3 - Frequencia de um nome por década
        4 - Sair 

Adios!
").to_stdout
  end
end