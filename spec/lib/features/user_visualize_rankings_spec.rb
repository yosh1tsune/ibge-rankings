require 'spec_helper'

describe 'user visualize rankings' do
  context 'state' do
    it 'successfully' do
      VCR.use_cassette('state_end_to_end') do
        allow_any_instance_of(IO).to receive(:gets).and_return('1', 'SP', 'ok', '4')
        expect {
          App.new.execute
        }.to output(File.open('./spec/support/state_end_to_end_test_output.txt').read).to_stdout
      end
    end
  end

  context 'state' do
    it 'successfully' do
      VCR.use_cassette('city_end_to_end') do
        allow_any_instance_of(IO).to receive(:gets).and_return('2', 'São Paulo, SP', 'ok', '4')
        expect {
          App.new.execute
        }.to output(File.open('./spec/support/city_end_to_end_test_output.txt').read).to_stdout
      end
    end
  end

  context 'decade' do
    it 'successfully' do
      VCR.use_cassette('decade_end_to_end') do
        allow_any_instance_of(IO).to receive(:gets).and_return('3', 'João, José', 'ok', '4')
        expect {
          App.new.execute
        }.to output(File.open('./spec/support/decade_end_to_end_test_output.txt').read).to_stdout
      end
    end
  end
end
