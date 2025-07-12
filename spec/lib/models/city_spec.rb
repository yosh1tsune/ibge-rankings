require 'spec_helper.rb'

describe City do
  context '::new' do
    it 'successfully instantiate a class object' do
      city = City.new(id: 1, name: 'São Paulo', state_acronym: 'SP')

      expect(city.id).to eq 1
      expect(city.name).to eq 'São Paulo'
      expect(city.state_acronym).to eq 'SP'
    end

    it 'fail if attributes are missing' do
      expect{
        City.new
    }.to raise_error ArgumentError,  'missing keywords: :id, :name, :state_acronym'
    end
  end

  context '::all' do
    it 'return all records' do
      city_one = City.new(id: 1, name: 'São Paulo', state_acronym: 'SP')
      city_two = City.new(id: 2, name: 'Rio de Janeiro', state_acronym: 'RJ')
      allow_any_instance_of(CitiesSingleton).to receive(:cities).and_return([city_one, city_two])

      expect(City.all).to eq [city_one, city_two]
    end

    it 'return empty array if there are no records' do
      allow_any_instance_of(CitiesSingleton).to receive(:cities).and_return([])

      expect(City.all).to eq []
    end
  end

  context '::find' do
    let(:city) { City.new(id: 1, name: 'São Paulo', state_acronym: 'SP') }

    before do
      allow_any_instance_of(CitiesSingleton).to receive(:cities).and_return([city])
    end

    it 'find one record in a collection' do
      found_city = City.find('São Paulo', 'SP')

      expect(found_city).to eq city
      expect(found_city.class).to eq City
    end

    it "don't find records" do
      found_city = City.find('São Paulo', 'RJ')

      expect(found_city).to eq nil
    end
  end
end
