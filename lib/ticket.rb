class Ticket
  attr_reader :fee, :from, :to

  def initialize(fee)
    @fee = fee
    @from = nil
    @to = nil
  end

  def enter(station_name)
    @from = station_name
  end
end