# 切符を表すクラスです。
class Ticket
  # 切符の購入額を返します。
  # @return [Integer] 切符の購入額
  attr_reader :fee

  # 乗車駅の名前を返します。<br>
  # まだ改札口を通っていない場合はnilを返します。
  # @return [Symbol, nil] 乗車駅の名前
  attr_reader :from

  # 切符を初期化します。
  # @param fee [Integer] 切符の購入額
  def initialize(fee)
    @fee = fee
    @from = nil
    @stale = false
  end

  # 乗車駅の名前を記録します。
  # @param station_name [Symbol] 乗車駅の名前
  def enter(station_name)
    @from = station_name
  end

  # 切符を使用済みにします。
  def mark_as_stale
    @stale = true
  end

  # 使用済みの切符であればtrueを返します。
  # @return [Boolean] 使用済みであればtrue
  def stale?
    @stale
  end
end