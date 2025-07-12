require 'spec_helper.rb'

describe Tables::LocalityTableService do
  let(:state) { State.new(id: 35, name: 'São Paulo', acronym: 'SP') }
  let(:data) do
    VCR.use_cassette('state') do
      API::NamesByLocalityRequestService.new(locality: state).execute
    end
  end

  before do
    allow_any_instance_of(API::NamesByLocalityRequestService).to receive(:execute).and_return(data)
  end

  context 'execute' do
    it 'build table' do
      table = described_class.new(title: "Ranking Geral: #{state.acronym}", data: data).execute

      expect(table.class).to eq Terminal::Table
      expect(table.title).to eq "Ranking Geral: #{state.acronym}"
    end
  end
end
