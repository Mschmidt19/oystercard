require_relative 'station'
require_relative 'journey'

class OysterCard

  #In order to avoid rounding issues with floats, prices are written in terms of cents
  MAXIMUM_LIMIT = 9000
  MINIMUM_FARE = 180

  def initialize
    @balance = 0
    @list_of_journies = []
    @journey = nil
  end

  attr_accessor :list_of_journies

  attr_reader :balance

  attr_reader :journey

  def pretty_balance
    return "£#{sprintf('%.2f', (balance.to_f / 100).round(2))}"
  end

  def top_up(amount)
    @amount = (amount * 100).to_i
    fail "Balance cannot exceed #{MAXIMUM_LIMIT.to_f / 100}" if exceeds_limit?
    @balance += @amount
  end

  # def in_journey?
  #   return false if @list_of_journies.empty?
  #   !@list_of_journies.last.completed?
  # end

  def touch_in(entry_station)
    fail "You must have a minimum balance of #{MINIMUM_FARE.to_f / 100} before touching in" unless has_minimum_fare?
    unless @journey == nil || @journey.complete?
      @list_of_journies.push(@journey)
      deduct(@journey.fare)
    end
      @journey = Journey.new(entry_station)
    # @list_of_journies.push({:entry => entry_station})
  end

  def touch_out(exit_station)
    if @journey.exit_station == nil
      @journey.finish(exit_station)
      deduct(@journey.fare)
    else
      # DEDUCT SHOULD BE IN HERE
      @list_of_journies.push(@journey)
      @journey = nil
      @journey.finish(exit_station)
    end
    @list_of_journies.push(@journey)
    # @list_of_journies.last[:exit] = exit_station
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
