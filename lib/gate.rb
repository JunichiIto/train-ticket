class Gate
  attr_reader :name

  STATIONS = %i(umeda juso shonai okamachi).freeze
  FEES = [150, 180, 220].freeze

  def initialize(name)
    @name = name
  end

  def enter(ticket)
    ticket.enter(name)
  end

  def exit(ticket)
    from = STATIONS.index(ticket.from)
    to = STATIONS.index(name)
    fee = FEES[to - from - 1]
    ticket.fee >= fee
  end
end