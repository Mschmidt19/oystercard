class OysterCard
  def initialize
    @balance = 0
  end

  attr_reader :balance

  def top_up(monies)
    @balance += monies
  end 
end
