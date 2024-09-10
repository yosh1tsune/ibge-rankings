require 'spec_helper.rb'

describe Calculators::PopulationPercentageCalculator do
  context '#execute' do
    it 'calculate successfully' do
      percentage = described_class.new(locality_id: 35, frequency: 4_591_905).execute

      expect(percentage).to eq 10.000000217774545
    end
  end
end
