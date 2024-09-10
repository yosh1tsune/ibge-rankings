require 'spec_helper.rb'

describe API::NamesByDecadeRequestService do
  context '#execute' do
    let(:decades) do
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

    it 'successfully make request and parse json' do
      VCR.use_cassette('decade') do
        response = described_class.new(names: 'João|José').execute

        expect(response.length).to eq 2
        expect(response[0][:nome]).to eq 'JOAO'
        expect(response[0][:res].map { |result| result[:periodo] }).to eq decades
        expect(response[1][:nome]).to eq 'JOSE'
        expect(response[1][:res].map { |result| result[:periodo] }).to eq decades
      end
    end
  end
end
