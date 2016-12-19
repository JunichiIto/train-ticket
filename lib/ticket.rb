class Ticket
  attr_reader :fee, :from, :to

  def initialize(fee)
    @fee = fee
    @from = nil
    @to = nil
    @stale = false
  end

  def enter(station_name)
    @from = station_name
  end

  def mark_as_stale
    @stale = true
  end

  def stale?
    @stale
  end
end