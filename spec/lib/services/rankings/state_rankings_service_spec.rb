require 'spec_helper.rb'

describe Rankings::StateRankingsService do
  let(:state) { State.new(id: 35, name: 'São Paulo', acronym: 'SP') }
  let(:rankings_titles) do
    [
      "Ranking Geral: #{state.acronym}",
      "Ranking Feminino: #{state.acronym}",
      "Ranking Masculino: #{state.acronym}"
    ]
  end

  before do
    allow(State).to receive(:find).and_return(state)
  end

  context 'execute' do
    it 'build ranking tables' do
      VCR.use_cassette('state_rankings') do
        ranking = described_class.new(state_acronym: state.acronym).execute

        expect(ranking.length).to eq 3
        expect(ranking.map(&:class)).to eq [Terminal::Table, Terminal::Table, Terminal::Table]
        expect(ranking.map(&:title)).to eq rankings_titles
      end
    end
  end
end
