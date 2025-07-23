require 'terminal-table'
require_relative '../calculators/population_percentage_calculator.rb'

# Módulo Tables contendo serviços de geração de tabelas de localidades no terminal.
module Tables
  # Serviço responsável por gerar uma tabela de localidades com posicionamento, nome,
  # frequência de uso e percentual em relação à população residente.
  #
  # @example
  #   data = [
  #     {
  #       localidade: '3550308',
  #       res: [
  #         { ranking: 1, nome: 'Maria', frequencia: 100000 },
  #         { ranking: 2, nome: 'João', frequencia: 90000 }
  #       ]
  #     }
  #   ]
  #   service = Tables::LocalityTableService.new(title: 'Nomes Populares', data: data)
  #   table = service.execute
  #   puts table
  class LocalityTableService
    # @return [String] título exibido no topo da tabela.
    attr_reader :title
    # @return [Array<Hash>] dados de localidades para preenchimento das linhas.
    attr_reader :data

    # Inicializa uma nova instância do serviço de geração de tabela de localidades.
    #
    # @param title [String] título exibido no topo da tabela.
    # @param data [Array<Hash>] array de hashes contendo :localidade e :res com dados de respostas.
    def initialize(title:, data:)
      @title = title
      @data = data
    end

    # Executa a geração da tabela formatada.
    #
    # @return [Terminal::Table] objeto de tabela pronto para exibição.
    def execute
      table
    end

    private

    # Cria o objeto de tabela com título, cabeçalhos e linhas formatadas.
    #
    # @api private
    # @return [Terminal::Table] tabela formatada com dados de localidades.
    def table
      Terminal::Table.new(
        title: title, headings: ['Posição', 'Nome', 'Uso', 'Percentual na população'], rows: rows(data)
      )
    end

    # Gera as linhas da tabela com base nos dados de resposta.
    #
    # @api private
    # @param data [Array<Hash>] dados de localidades para geração das linhas.
    # @return [Array<Array>] array de arrays com valores em ordem [posição, nome, uso, percentual].
    def rows(data)
      data[0][:res].map do |response|
        percentual = population_percentage(data[0][:localidade], response[:frequencia])
        [
          response[:ranking],
          response[:nome],
          response[:frequencia],
          "#{percentual.round(2)}%"
        ]
      end
    end

    # Calcula o percentual de frequência em relação à população para uma localidade.
    #
    # @api private
    # @param id [String] código da localidade para cálculo.
    # @param frequency [Numeric] frequência de ocorrência do nome.
    # @return [Float] percentual calculado, entre 0.0 e 100.0.
    def population_percentage(id, frequency)
      Calculators::PopulationPercentageCalculator.new(locality_id: id, frequency: frequency).execute
    end
  end
end
