# 改札口を表すクラスです。
# @example 梅田で150円の切符を購入して乗車し、十三で降車する
#   ticket = Ticket.new(150)
#   gate_from = Gate.new(:umeda)
#   gate_to = Gate.new(:juso)
#   gate_from.enter(ticket)
#   gate_to.exit(ticket) #=> true
class Gate
  # 駅の名前を返します。
  # @return [Symbol] 駅の名前
  attr_reader :name

  # 有効な駅名を格納した配列です。
  STATIONS = [
      :umeda,   # 梅田
      :juso,    # 十三
      :shonai,  # 庄内
      :okamachi # 岡町
  ].freeze

  # 区間ごとの運賃を格納した配列です。
  FEES = [
      150, # 1区間の運賃
      180, # 2区間の運賃
      220  # 3区間の運賃
  ].freeze

  # 改札口を初期化します。
  # @param name [Symbol] 駅の名前
  def initialize(name)
    @name = name
  end

  # 改札口から入場します。
  # 切符には駅の名前が記録されます。
  # @param ticket [Ticket] 切符
  # @raise [AlreadyEnteredTicketError] すでに入場済みの切符を使った場合に発生します。
  def enter(ticket)
    raise AlreadyEnteredTicketError unless ticket.from.nil?

    ticket.enter(name)
  end

  # 改札口から出場します。<br>
  # 切符の運賃が足りていればtrueを返し、切符を使用済みにします。
  # @param ticket [Ticket] 切符
  # @return [Boolean] 運賃が足りていればtrue、不足していればfalse
  # @raise [StaleTicketError] 使用済みの切符を使った場合に発生します。
  # @raise [NotEnteredTicketError] 未入場の切符を使った場合に発生します。
  # @raise [ExitSameStationError] 乗車駅と同じ駅で出場した場合に発生します。
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