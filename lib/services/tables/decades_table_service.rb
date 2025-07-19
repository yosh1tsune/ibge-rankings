require 'terminal-table'

# = Tables::DecadesTableService
#
# Serviço responsável por gerar uma tabela formatada que exibe a frequência de uso
# de nomes por década, utilizando dados do IBGE.
#
# == Descrição
# Esta classe processa dados de frequência de nomes por período e gera uma tabela
# visualmente organizada usando a gem terminal-table. A tabela mostra como a
# popularidade de determinados nomes variou ao longo das décadas.
#
# == Estrutura dos dados esperados
# O parâmetro +data+ deve ser um array de hashes com a seguinte estrutura:
#   [
#     {
#       nome: "João",
#       res: [
#         { periodo: "[1930,1940[", frequencia: 1234 },
#         { periodo: "[1940,1950[", frequencia: 2345 },
#         ...
#       ]
#     },
#     ...
#   ]
#
# == Exemplo de uso
#   data = [
#     {
#       nome: "Maria",
#       res: [
#         { periodo: "[1990,2000[", frequencia: 5000 },
#         { periodo: "[2000,2010[", frequencia: 4500 }
#       ]
#     }
#   ]
#
#   service = Tables::DecadesTableService.new(data: data)
#   table = service.execute
#   puts table
#
# == Saída esperada
# A tabela gerada terá o formato:
#   +----------------------+-------+
#   | Frequência de uso por década: Maria |
#   +----------------------+-------+
#   | Década               | Maria |
#   +----------------------+-------+
#   | [1990,2000[          | 5000  |
#   | [2000,2010[          | 4500  |
#   +----------------------+-------+
#
module Tables
  class DecadesTableService
    # @return [Array<Hash>] dados contendo informações de nomes e suas frequências por década
    attr_reader :data

    # Inicializa uma nova instância do serviço de tabela de décadas
    #
    # @param data [Array<Hash>] array de hashes contendo dados de nomes e frequências
    #   Cada hash deve ter as chaves :nome e :res, onde :res é um array de hashes
    #   com :periodo e :frequencia
    # @raise [ArgumentError] se data não for um array ou estiver vazio
    def initialize(data:)
      @data = data
      @headers = ['Década']
    end

    # Executa a geração da tabela
    #
    # @return [Terminal::Table] tabela formatada pronta para exibição
    def execute
      table
    end

    private

    # Constrói e retorna a tabela Terminal::Table configurada
    #
    # @return [Terminal::Table] instância da tabela com título, cabeçalhos e linhas
    # @private
    def table
      Terminal::Table.new(
        title: "Frequência de uso por década: #{title}", headings: headers.flatten, rows: build_rows
      )
    end

    # Gera o título da tabela baseado nos nomes presentes nos dados
    #
    # @return [String] nomes concatenados por vírgula e espaço
    # @example
    #   # Para data = [{ nome: "João" }, { nome: "Maria" }]
    #   title #=> "João, Maria"
    # @private
    def title
      data.map { |response| response[:nome] }.join(', ')
    end

    # Constrói o array de cabeçalhos da tabela
    #
    # @return [Array<String>] array contendo 'Década' seguido pelos nomes
    # @note Este método modifica o array @headers adicionando os nomes
    # @private
    def headers
      @headers << data.map { |response| response[:nome] }
    end

    # Constrói as linhas de dados da tabela
    #
    # Este método é o núcleo da lógica de construção da tabela. Ele:
    # 1. Itera sobre cada período/década predefinido
    # 2. Para cada nome nos dados, busca a frequência correspondente ao período
    # 3. Adiciona a frequência à linha se o período for encontrado
    #
    # @return [Array<Array>] array de arrays, onde cada sub-array representa uma linha
    # @note Este método modifica o array @rows durante o processamento
    # @private
    def build_rows
      @rows = rows
      @rows.filter_map do |row|
        data.filter_map do |response|
          response[:res].filter_map do |results|
            row << results[:frequencia] if row.include?(results[:periodo])
          end
        end.flatten
      end
      return @rows
    end

    # Define os períodos/décadas disponíveis para análise
    #
    # @return [Array<Array<String>>] array de arrays, cada um contendo um período
    # @note Os períodos seguem o formato matemático de intervalos:
    #   - '[' indica inclusivo (valor incluído)
    #   - '[' no final indica exclusivo (valor não incluído)
    # @example
    #   rows[0] #=> ['1930[']          # Anterior a 1930
    #   rows[1] #=> ['[1930,1940[']    # De 1930 até 1939
    # @private
    def rows
      [
        ['1930['], ['[1930,1940['], ['[1940,1950['], ['[1950,1960['],
        ['[1960,1970['], ['[1970,1980['], ['[1980,1990['], ['[1990,2000['],
        ['[2000,2010[']
      ]
    end
  end
end
