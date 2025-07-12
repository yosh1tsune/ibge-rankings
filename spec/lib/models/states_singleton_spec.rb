require 'spec_helper.rb'

describe StatesSingleton do
  let(:instance) { VCR.use_cassette("states") { described_class.instance } }

  context '#states' do
    it 'request states from ibge api and store into an array of State' do
      expect(instance.states.class).to eq Array
      expect(instance.states.first.class).to eq State
    end
  end
end
