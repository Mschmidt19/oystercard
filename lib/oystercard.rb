class OysterCard

  MAXIMUM_LIMIT = 90.00

  def initialize
    @balance = 0.00
    @in_journey = false
  end

  attr_reader :balance

  def top_up(monies)
    @monies = monies
    fail "Balance cannot exceed #{MAXIMUM_LIMIT}" if exceeds_limit?
    @balance += monies
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceeds_limit?
    return true if (@balance + @monies) > MAXIMUM_LIMIT
    false
  end
end
