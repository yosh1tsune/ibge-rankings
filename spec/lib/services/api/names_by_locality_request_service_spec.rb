require 'spec_helper.rb'

describe API::NamesByLocalityRequestService do
  context '#execute' do
    let(:city) { City.new(id: 3550308, name: 'São Paulo', state_acronym: 'SP') }
    let(:state) { State.new(id: 35, name: 'São Paulo', acronym: 'SP') }

    context 'successfully make request and parse json' do
      it 'for a city' do
        VCR.use_cassette('city') do
          response = described_class.new(locality: city).execute

          expect(response[0][:localidade].to_i).to eq city.id
          expect(response[0][:sexo]).to eq nil
          expect(response[0][:res].length).to eq 20
        end
      end

      it 'for a state' do
        VCR.use_cassette('state') do
          response = described_class.new(locality: state).execute

          expect(response[0][:localidade].to_i).to eq state.id
          expect(response[0][:sexo]).to eq nil
          expect(response[0][:res].length).to eq 20
        end
      end

      context 'providing options' do
        it 'sexo=M' do
          VCR.use_cassette('state_males') do
            response = described_class.new(locality: state, options: 'sexo=M').execute

            expect(response[0][:localidade].to_i).to eq state.id
            expect(response[0][:sexo]).to eq 'm'
            expect(response[0][:res].length).to eq 20
          end
        end

        it 'sexo=F' do
          VCR.use_cassette('state_females') do
            response = described_class.new(locality: state, options: 'sexo=F').execute

            expect(response[0][:localidade].to_i).to eq state.id
            expect(response[0][:sexo]).to eq 'f'
            expect(response[0][:res].length).to eq 20
          end
        end
      end
    end
  end
end
