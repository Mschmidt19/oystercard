class Journey

  MINIMUM_FARE = 180
  PENALTY = 600

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = !entry_station
    # @current_journey = {}
  end

  attr_reader :entry_station

  attr_reader :exit_station

  attr_accessor :current_journey

  def start(station)
    @entry_station = station if @entry == nil
    @complete = false
    # @current_journey[:entry] = @entry_station
  end

  def finish(station)
    @exit_station = station
    @complete = true
    # @current_journey[:exit] = @exit_station
  end

  def complete?
    @complete
  end

  def fare
    return PENALTY unless complete?
    return MINIMUM_FARE
  end

end
