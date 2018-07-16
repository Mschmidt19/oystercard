class OysterCard

  MAXIMUM_LIMIT = 90.00

  def initialize
    @balance = 0.00
    @monies = 0.00
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

  private
  
  def exceeds_limit?
    return true if (@balance + @monies) > MAXIMUM_LIMIT
    false
  end
end
