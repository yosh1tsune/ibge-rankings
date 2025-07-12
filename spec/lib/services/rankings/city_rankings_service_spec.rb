require 'spec_helper.rb'

describe Rankings::CityRankingsService do
  let(:city) { City.new(id: 3550308, name: 'São Paulo', state_acronym: 'SP') }
  let(:rankings_titles) do
    [
      "Ranking Geral: #{city.name}, #{city.state_acronym}",
      "Ranking Feminino: #{city.name}, #{city.state_acronym}",
      "Ranking Masculino: #{city.name}, #{city.state_acronym}"
    ]
  end

  before do
    allow(City).to receive(:find).and_return(city)
  end

  context 'execute' do
    it 'build ranking tables' do
      VCR.use_cassette('city_rankings') do
        ranking = described_class.new(local: 'São Paulo, SP').execute

        expect(ranking.length).to eq 3
        expect(ranking.map(&:class)).to eq [Terminal::Table, Terminal::Table, Terminal::Table]
        expect(ranking.map(&:title)).to eq rankings_titles
      end
    end
  end
end
