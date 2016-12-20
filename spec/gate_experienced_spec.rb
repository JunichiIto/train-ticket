require_relative '../spec/spec_helper'

describe Gate, 'for experienced' do
  def assert_exit(from, to, fee, result)
    ticket = Ticket.new(fee)
    gate_from = Gate.new(from)
    gate_to = Gate.new(to)
    gate_from.enter(ticket)
    expect(gate_to.exit(ticket)).to eq result
    expect(ticket.stale?).to eq result
  end

  context '下り' do
    context '料金がちょうどの場合' do
      example '通過できる' do
        assert_exit(:umeda, :juso, 150, true)
      end
    end

    context '料金が足りない場合' do
      example '通過できない' do
        assert_exit(:umeda, :shonai, 150, false)
      end
    end
  end

  context '上り' do
    context '料金がちょうどの場合' do
      example '通過できる' do
        assert_exit(:okamachi, :shonai, 150, true)
      end
    end

    context '料金が足りない場合' do
      example '通過できない' do
        assert_exit(:okamachi, :juso, 150, false)
      end
    end
  end

  context '下り全体' do
    where(:from, :to, :fee, :result) do
      [
          [:umeda, :juso, 150, true],
          [:umeda, :juso, 180, true],
          [:umeda, :shonai, 150, false],
          [:umeda, :shonai, 180, true],
          [:umeda, :shonai, 220, true],
          [:umeda, :okamachi, 180, false],
          [:umeda, :okamachi, 220, true],
          [:juso, :shonai, 150, true],
          [:juso, :shonai, 180, true],
          [:juso, :okamachi, 150, false],
          [:juso, :okamachi, 180, true],
          [:juso, :okamachi, 220, true],
          [:shonai, :okamachi, 150, true],
          [:shonai, :okamachi, 180, true],
      ]
    end

    with_them do
      example '判定が正しい' do
        assert_exit(from, to, fee, result)
      end
    end
  end

  context '上り全体' do
    where(:from, :to, :fee, :result) do
      [
          [:okamachi, :shonai, 150, true],
          [:okamachi, :shonai, 180, true],
          [:okamachi, :juso, 150, false],
          [:okamachi, :juso, 180, true],
          [:okamachi, :juso, 220, true],
          [:okamachi, :umeda, 180, false],
          [:okamachi, :umeda, 220, true],
          [:shonai, :juso, 150, true],
          [:shonai, :juso, 180, true],
          [:shonai, :umeda, 150, false],
          [:shonai, :umeda, 180, true],
          [:shonai, :umeda, 220, true],
          [:juso, :umeda, 150, true],
          [:juso, :umeda, 180, true],
      ]
    end

    with_them do
      example '判定が正しい' do
        assert_exit(from, to, fee, result)
      end
    end
  end

  context '同じ駅で降りる場合' do
    example 'エラーが発生する' do
      expect { assert_exit(:umeda, :umeda, 150, false) }.to raise_error(ExitSameStationError)
    end
  end

  context '改札を通った切符でもう一度入場する場合' do
    example 'エラーが発生する' do
      ticket = Ticket.new(150)
      umeda = Gate.new(:umeda)
      umeda.enter(ticket)
      expect { umeda.enter(ticket) }.to raise_error(AlreadyEnteredTicketError)
    end
  end

  context '使用済みの切符でもう一度降りる場合' do
    example 'エラーが発生する' do
      ticket = Ticket.new(150)
      umeda = Gate.new(:umeda)
      juso = Gate.new(:juso)
      umeda.enter(ticket)
      expect(juso.exit(ticket)).to be_truthy
      expect { juso.exit(ticket) }.to raise_error(StaleTicketError)
    end
  end

  context '改札を通っていない切符で降りる場合' do
    example 'エラーが発生する' do
      ticket = Ticket.new(150)
      umeda = Gate.new(:umeda)
      expect { umeda.exit(ticket) }.to raise_error(NotEnteredTicketError)
    end
  end
end