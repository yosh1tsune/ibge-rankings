require 'csv'

# Módulo Calculators contendo serviços de cálculo diversos.
module Calculators
  # Serviço responsável por calcular o percentual de frequência de ocorrência
  # em relação à população residente de uma localidade, com base em dados do IBGE.
  #
  # @example
  #   service = Calculators::PopulationPercentageCalculator.new(
  #     locality_id: '3550308', frequency: 10000
  #   )
  #   service.execute # => 5.27
  #
  class PopulationPercentageCalculator
    # Código da localidade conforme base de dados do IBGE.
    #
    # @return [String]
    attr_reader :locality_id

    # Frequência de ocorrência para cálculo do percentual.
    #
    # @return [Numeric]
    attr_reader :frequency

    # Inicializa uma nova instância do serviço de cálculo de percentual de população.
    #
    # @param locality_id [String] código da localidade para consulta no CSV de população
    # @param frequency [Numeric] quantidade de ocorrências na localidade
    def initialize(locality_id:, frequency:)
      @locality_id = locality_id
      @frequency = frequency
    end

    # Executa o cálculo do percentual de frequência em relação à população.
    #
    # @return [Float] percentual calculado, entre 0.0 e 100.0
    def execute
      (frequency / population.to_f) * 100
    end

    private

    # Retorna a população residente da localidade informada, extraída de arquivo CSV.
    #
    # @api private
    # @return [Integer] quantidade de habitantes na localidade
    # @raise [Errno::ENOENT] caso o arquivo de população não seja encontrado
    def population
      csv = CSV.parse(
        File.read('./spec/support/populacao_2019.csv'),
        headers: :first_row
      )
      csv.find { |row| row['Cód.'] == locality_id }['População Residente - 2019']
    end
  end
end
