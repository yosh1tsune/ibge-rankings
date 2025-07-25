require_relative 'states_singleton.rb'

class State
  attr_reader :id, :name, :acronym

  def self.all
    StatesSingleton.instance.states
  end

  def self.find(acronym)
    all.select { |state| state.acronym == acronym }.first
  end

  def initialize(id:, name:, acronym:)
    @id = id
    @name = name
    @acronym = acronym
  end

  def print
    puts "#{name} - #{acronym}"
  end
end
