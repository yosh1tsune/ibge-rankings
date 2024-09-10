require 'spec_helper.rb'

describe Rankings::NamesByDecadeService do
  let(:columns) do
    [
      "1930[",
      "[1930,1940[",
      "[1940,1950[",
      "[1950,1960[",
      "[1960,1970[",
      "[1970,1980[",
      "[1980,1990[",
      "[1990,2000[",
      "[2000,2010["
    ]
  end

  context 'execute' do
    it 'build table' do
      VCR.use_cassette('decade') do
        ranking = described_class.new(names: 'João, José').execute

        expect(ranking.class).to eq Terminal::Table
        expect(ranking.title).to eq 'Frequência de uso por década: JOAO, JOSE'
        expect(ranking.columns.first).to eq columns
        expect(ranking.headings.first.cells.map(&:value)).to eq ['Década', 'JOAO', 'JOSE']
      end
    end
  end
end
