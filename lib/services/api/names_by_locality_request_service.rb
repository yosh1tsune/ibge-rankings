require_relative 'names_request_service.rb'

# API::NamesByLocalityRequestService
module API
  class NamesByLocalityRequestService < API::NamesRequestService
    attr_reader :locality, :options

    def initialize(locality:, options: nil)
      @locality = locality
      @options = options
    end

    private

    def url
      URI.parse(URI::Parser.new.escape("#{ENDPOINT}/ranking/?localidade=#{locality.id}&#{options}"))
    end
  end
end
