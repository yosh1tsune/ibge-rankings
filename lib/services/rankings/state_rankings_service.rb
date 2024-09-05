require_relative '../../services/api/names_ranking_service.rb'

# Rankings::StateRankingsService
module Rankings
  class StateRankingsService
    attr_reader :state_acronym

    def initialize(state_acronym:)
      @state_acronym = state_acronym
    end

    def execute
      rankings
    end

    private

    def rankings
      [
        { title: "Ranking Geral: #{state.acronym}", options: nil },
        { title: "Ranking Feminino: #{state.acronym}", options: 'sexo=F' },
        { title: "Ranking Masculino: #{state.acronym}", options: 'sexo=M' }
      ].map { |data| table(data) }
    end

    def state
      @state ||= State.find(state_acronym)
    end

    def table(data)
      puts Tables::LocalityTableService.new(title: data[:title], data: response(data[:options])).execute
    end

    def response(options = nil)
      Api::NamesRankingService.new(locality_id: state.id, options: options).execute
    end
  end
end
