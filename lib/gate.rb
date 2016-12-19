class Gate
  attr_reader :name

  STATIONS = %i(umeda juso shonai okamachi).freeze
  FEES = [150, 180, 220].freeze

  def initialize(name)
    @name = name
  end

  def enter(ticket)
    raise AlreadyEnteredTicketError unless ticket.from.nil?

    ticket.enter(name)
  end

  def exit(ticket)
    raise StaleTicketError if ticket.stale?
    raise NotEnteredTicketError if ticket.from.nil?
    raise ExitSameStationError if ticket.from == name

    from = STATIONS.index(ticket.from)
    to = STATIONS.index(name)
    distance = (to - from).abs
    fee = FEES[distance - 1]
    if ticket.fee >= fee
      ticket.mark_as_stale
      true
    else
      false
    end
  end
end