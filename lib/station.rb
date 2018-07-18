class Station
  def initialize(hash)
    @name = hash[:name]
    @zone = hash[:zone]
  end
  attr_reader :name
  attr_reader :zone
end
