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
end