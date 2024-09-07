require 'spec_helper.rb'

describe CitiesSingleton do
  let(:instance) { VCR.use_cassette("states_and_cities") { described_class.instance } }

  context '#cities' do
    it 'request cities from ibge api and store into an array of City' do
      expect(instance.cities.class).to eq Array
      expect(instance.cities.first.class).to eq City
    end
  end
end
