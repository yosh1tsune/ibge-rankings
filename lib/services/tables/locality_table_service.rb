require 'faraday'
require 'json'
require_relative '../../services/calculators/population_percentage_calculator.rb'

# Tables::LocalityTableService
module Tables
  class LocalityTableService
    attr_reader :title, :data

    def initialize(title:, data:)
      @title = title
      @data = data
    end

    def execute
      table
    end

    private

    def table
      Terminal::Table.new(
        title: title, headings: ['Posição', 'Nome', 'Uso', 'Percentual na população'], rows: rows(data)
      )
    end

    def rows(data)
      data[0][:res].map do |response|
        populacao = population_percentage(data[0][:localidade], response[:frequencia])
        [response[:ranking], response[:nome], response[:frequencia], "#{ populacao.round(2) }%"]
      end
    end

    def population_percentage(id, frequency)
      Calculators::PopulationPercentageCalculator.new(id: id, frequency: frequency).execute
    end
  end
end
