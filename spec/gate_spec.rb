require_relative '../spec/spec_helper'

describe Gate do
  context '下り' do
    context '料金がちょうどの場合' do
      example '通過できる' do
        ticket = Ticket.new(150)
        umeda = Gate.new(:umeda)
        juso = Gate.new(:juso)
        umeda.enter(ticket)
        expect(juso.exit(ticket)).to be_truthy
      end
    end

    context '料金が足りない場合' do
      example '通過できない' do
        ticket = Ticket.new(150)
        umeda = Gate.new(:umeda)
        shonai = Gate.new(:shonai)
        umeda.enter(ticket)
        expect(shonai.exit(ticket)).to be_falsey
      end
    end
  end

  context '上り' do
    context '料金がちょうどの場合' do
      example '通過できる' do
        ticket = Ticket.new(150)
        okamachi = Gate.new(:okamachi)
        shonai = Gate.new(:shonai)
        okamachi.enter(ticket)
        expect(shonai.exit(ticket)).to be_truthy
      end
    end

    context '料金が足りない場合' do
      example '通過できない' do
        ticket = Ticket.new(150)
        okamachi = Gate.new(:okamachi)
        juso = Gate.new(:juso)
        okamachi.enter(ticket)
        expect(juso.exit(ticket)).to be_falsey
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
        ticket = Ticket.new(fee)
        gate_from = Gate.new(from)
        gate_to = Gate.new(to)
        gate_from.enter(ticket)
        expect(gate_to.exit(ticket)).to eq result
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
        ticket = Ticket.new(fee)
        gate_from = Gate.new(from)
        gate_to = Gate.new(to)
        gate_from.enter(ticket)
        expect(gate_to.exit(ticket)).to eq result
      end
    end
  end
end