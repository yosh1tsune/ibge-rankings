require 'spec_helper.rb'

describe State do
    let(:state) { State.new(id: 1, name: 'São Paulo', acronym: 'SP') }

    context '::new' do
    it 'successfully instantiate a class object' do
      expect(state.id).to eq 1
      expect(state.name).to eq 'São Paulo'
      expect(state.acronym).to eq 'SP'
    end

    it 'fail if attributes are missing' do
      expect{
        State.new
    }.to raise_error ArgumentError,  'missing keywords: :id, :name, :acronym'
    end
  end

  context '::all' do
    it 'return all records' do
      state_one = State.new(id: 1, name: 'São Paulo', acronym: 'SP')
      state_two = State.new(id: 2, name: 'Rio de Janeiro', acronym: 'RJ')
      allow_any_instance_of(StatesSingleton).to receive(:states).and_return([state_one, state_two])

      expect(State.all).to eq [state_one, state_two]
    end

    it 'return empty array if there are no records' do
      allow_any_instance_of(StatesSingleton).to receive(:states).and_return([])

      expect(State.all).to eq []
    end
  end

  context '::find' do
    before do
      allow_any_instance_of(StatesSingleton).to receive(:states).and_return([state])
    end

    it 'find one record in a collection' do
      found_state = State.find('SP')

      expect(found_state).to eq state
      expect(found_state.class).to eq State
    end

    it "don't find records" do
      found_state = State.find('RJ')

      expect(found_state).to eq nil
    end
  end

  context '#print' do
    it 'print a string containing name and acronym in the cli' do
      expect {
        state.print
    }.to output("#{state.name} - #{state.acronym}\n").to_stdout
    end
  end
end
