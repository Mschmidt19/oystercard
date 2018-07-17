class OysterCard

  MAXIMUM_LIMIT = 90.00
  MINIMUM_FARE = 1.00

  def initialize
    @balance = 0.00
  end

  attr_reader :balance

  attr_reader :entry_station

  def top_up(amount)
    @amount = amount
    fail "Balance cannot exceed #{MAXIMUM_LIMIT}" if exceeds_limit?
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "You must have a minimum balance of #{MINIMUM_FARE} before touching in" unless has_minimum_fare?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def exceeds_limit?
    (@balance + @amount) > MAXIMUM_LIMIT
  end

  def has_minimum_fare?
    @balance >= MINIMUM_FARE
  end
end
