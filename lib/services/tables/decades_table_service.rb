require 'terminal-table'

# Tables::DecadesTableService
module Tables
  class DecadesTableService
    attr_reader :data

    def initialize(data:)
      @data = data
      @headers = ['Década']
    end

    def execute
      table
    end

    private

    def table
      Terminal::Table.new(
        title: "Frequência de uso por década: #{title}", headings: headers.flatten, rows: build_rows
      )
    end

    def title
      data.map { |response| response[:nome] }.join(', ')
    end

    def headers
      @headers << data.map { |response| response[:nome] }
    end

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

    def rows
      [
        ['1930['], ['[1930,1940['], ['[1940,1950['], ['[1950,1960['],
        ['[1960,1970['], ['[1970,1980['], ['[1980,1990['], ['[1990,2000['],
        ['[2000,2010[']
      ]
    end
  end
end
