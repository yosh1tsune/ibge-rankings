require 'faraday'
require 'json'
require 'uri'
require_relative '../tables/decades_table_service.rb'
require_relative '../api/names_by_decade_request_service.rb'

# Rankings::NamesByDecadeService
module Rankings
  class NamesByDecadeService
    attr_reader :names

    def initialize(names)
      @names = names.gsub(',', '|').gsub(' ', '')
    end

    def execute
      puts Tables::DecadesTableService.new(data: response).execute
    end

    private

    def response
      API::NamesByDecadeRequestService.new(names: names).execute
    end
  end
end
