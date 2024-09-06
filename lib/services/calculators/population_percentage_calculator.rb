require 'csv'

# Calculators::PopulationPercentageCalculator
module Calculators
  class PopulationPercentageCalculator
    attr_reader :id, :frequency

    def initialize(id:, frequency:)
      @id = id
      @frequency = frequency
    end

    def execute
      (frequency / population.to_f) * 100
    end

    private

    def population
      csv = CSV.parse(File.read('./spec/support/populacao_2019.csv'), headers: :first_row)
      csv.find{ |row| row['Cód.'] == "#{id}"}['População Residente - 2019']
    end
  end
end
