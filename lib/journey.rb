class Journey

  def in_journey?
    return false if @list_of_journies.empty?
    !@list_of_journies.last.key?(:exit)
  end

  def touch_in(entry_station)
    fail "You must have a minimum balance of #{MINIMUM_FARE} before touching in" unless has_minimum_fare?
    @list_of_journies.push({:entry => entry_station})
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @list_of_journies.last[:exit] = exit_station
  end

  def deduct(fare)
    @balance -= fare
  end
  
  private

  def exceeds_limit?
    (@balance + @amount) > MAXIMUM_LIMIT
  end

  def has_minimum_fare?
    @balance >= MINIMUM_FARE
  end
end
