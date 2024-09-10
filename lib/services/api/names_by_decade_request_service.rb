require_relative 'names_request_service.rb'

# API::NamesByDecadeRequestService
module API
  class NamesByDecadeRequestService < API::NamesRequestService
    attr_reader :names

    def initialize(names:)
      @names = names
    end

    private

    def response
      data = Faraday.get(url)
      JSON.parse(data.body, symbolize_names: true)
    end

    def url
      URI.parse(URI::Parser.new.escape("#{ENDPOINT}/#{names}?decada"))
    end
  end
end
