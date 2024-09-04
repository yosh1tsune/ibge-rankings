# Nomes no Brasil IBGE

Esta aplicação Ruby apresenta dados sobre os nomes mais utilizados no Brasil
segundo o Censo do IBGE de 2010, consumindo dados das APIs de
[Localidades](https://servicodados.ibge.gov.br/api/docs/localidades?versao=1)
e [Nomes](https://servicodados.ibge.gov.br/api/docs/censos/nomes?versao=2)
fornecidas pelo Instituto.

## gems utilizadas

``` gem 'byebug' ```

``` gem 'faraday' ```

``` gem 'rspec' ```

``` gem 'terminal-table' ```

## Iniciando o Projeto

Após clonar o repospitório, rode o comando ``` bundle install ```

Para iniciar a aplicação, rode o comando ``` ruby lib/app.rb ```

Na primeira execução, será feita a configuração do banco de dados. Isso levará
alguns minutos, e logo após a aplicação estará pronta para uso.

## Realizando as consultas

O primeiro menu da aplicação mostrará quatro opções de interação, acesse opções
digitando o indíce numérico da desejada.

### Consulta de Rankings das Unidades Federativas

Escolher a opção 1 mostrará uma lista das Unidades Federativas do Brasil (nomes
e siglas), para consultar o ranking de nomes mais usados de uma UF digite sua
sigla.

Após a consulta, os dados serão exibidos e a aplicação retornará para o menu
inicial.

### Consulta de Rankings por Cidades

Escolher a opção 2 mostrará novamente a listagem de Unidades Federativas.

Agora, no entanto, será necessário inserir o nome da Cidade
(sempre com acentuação) e a sigla de sua UF, separados por vírgula
(Ex: São Paulo, SP).

Caso seja inserido, por exemplo, 'São Paulo SP', sem a vírgula, a aplicação
adotara que 'São Paulo SP' constitui apenas o nome da cidade e não retornará
dados.

É necessário fornecer a Unidade Federativa pois existem diversas [cidades
homonimas no Brasil](https://www.embrapa.br/manual-de-referenciacao/anexo-cidades-homonimas),
contudo existe uma lei que obriga a consulta ao IBGE no ato de criação
ou alteração do nome de municípios, para que não haja essa igualdade dentro de
uma mesma Unidade Federativa.

Após a consulta, os dados serão exibidos e a aplicação retornará para o menu
inicial.

### Consulta de Nomes por Década

A opção 3 permite a consulta de frequência de utilização de nomes ao longo das
décadas em ambito nacional, partindo de 1930.

É possível consultar um ou mais nomes, sempre separados por vírgula
(Ex: Bruno, Felipe).

No Censo 2010 o IBGE levou em conta apenas o primeiro nome dos indivíduos,
portanto não é possível a pesquisa de nomes compostos como 'João Carlos'.

Caso os nomes sejam enviados sem a separação por vírgula eles serão concatenados
(Ex: João Carlos vira JoãoCarlos), e possivelmente não retornarão dados visto que
o nome gerado poderá não ser encontrado na base de dados do IBGE.

Após a consulta, os dados serão exibidos e a aplicação retornará para o menu
inicial.

### Encerrando a aplicação

Para encerrar a execução, basta selecionar a opção 4 no menu inicial da aplicação.

Além disso, todos os menus de consulta possuem a opção de retornar ao inicial
sem realizar a consultar, digitando 'ok'.
