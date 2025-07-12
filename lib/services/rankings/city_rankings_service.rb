require_relative '../api/names_by_locality_request_service.rb'
require_relative '../tables/locality_table_service.rb'

# Rankings::CityRankingsService
module Rankings
  class CityRankingsService
    attr_reader :name, :state_acronym

    def initialize(local:)
      @name = local.split(',')[0].delete(',').lstrip.rstrip
      @state_acronym = local.split(',')[1].lstrip.rstrip if local.split(',')[1] != nil
    end

    def execute
      rankings
    end

    private

    def rankings
      [
        { title: "Ranking Geral: #{city.name}, #{city.state_acronym}", options: nil },
        { title: "Ranking Feminino: #{city.name}, #{city.state_acronym}", options: 'sexo=F' },
        { title: "Ranking Masculino: #{city.name}, #{city.state_acronym}", options: 'sexo=M' }
      ].map { |data| table(data) }
    end

    def city
      @city ||= City.find(name, state_acronym)
    end

    def table(data)
      Tables::LocalityTableService.new(title: data[:title], data: response(data[:options])).execute
    end

    def response(options = nil)
      API::NamesByLocalityRequestService.new(locality: city, options: options).execute
    end
  end
end
