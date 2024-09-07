require_relative '../../config/initializers/cities_singleton.rb'

class City
  attr_reader :id, :name, :state_acronym

  def self.all
    CitiesSingleton.instance.cities
  end

  def self.find(name, state_acronym)
    all.select { |city| city.name.upcase == name.upcase && city.state_acronym.upcase == state_acronym.upcase }.first
  end

  def initialize(id:, name:, state_acronym:)
    @id = id
    @name = name
    @state_acronym = state_acronym
  end
end
