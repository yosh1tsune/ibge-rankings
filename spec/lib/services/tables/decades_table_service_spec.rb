require 'spec_helper.rb'

describe Tables::DecadesTableService do
  let(:data) do
    VCR.use_cassette('decade') do
      API::NamesByDecadeRequestService.new(names: 'João|José').execute
    end
  end
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

  before do
    allow_any_instance_of(API::NamesByDecadeRequestService).to receive(:execute).and_return(data)
  end

  context 'execute' do
    it 'build table' do
      table = described_class.new(data: data).execute

      expect(table.class).to eq Terminal::Table
      expect(table.title).to eq "Frequência de uso por década: JOAO, JOSE"
      expect(table.columns.first).to eq columns
      expect(table.headings.first.cells.map(&:value)).to eq ['Década', 'JOAO', 'JOSE']
    end
  end
end
