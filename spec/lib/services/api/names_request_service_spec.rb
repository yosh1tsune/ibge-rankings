require 'spec_helper.rb'

describe API::NamesRequestService do
  context '#execute' do
    it 'raise NotImplementedError for #response' do
      expect {
        described_class.new.execute
      }.to raise_error NotImplementedError, '#response has to be implemented by children classes'
    end
  end
end
