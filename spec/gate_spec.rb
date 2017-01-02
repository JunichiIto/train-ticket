require_relative '../spec/spec_helper'

describe Gate do
  example '出場許可の判定が正しいこと' do
    umeda = Gate.new(:umeda)
    juso = Gate.new(:juso)
    shonai = Gate.new(:shonai)
    okamachi = Gate.new(:okamachi)

    # 下り
    # 1区間
    ticket = Ticket.new(150)
    umeda.enter(ticket)
    expect(juso.exit(ticket)).to be_truthy

    # NOTE: 以下のテストは自分でコメントを外しながらテスト駆動開発を進めてください

    # # 2区間
    # ticket = Ticket.new(150)
    # umeda.enter(ticket)
    # expect(shonai.exit(ticket)).to be_falsey
    #
    # ticket = Ticket.new(180)
    # umeda.enter(ticket)
    # expect(shonai.exit(ticket)).to be_truthy
    #
    # ticket = Ticket.new(220)
    # umeda.enter(ticket)
    # expect(shonai.exit(ticket)).to be_truthy
    #
    # # 3区間
    # ticket = Ticket.new(180)
    # umeda.enter(ticket)
    # expect(okamachi.exit(ticket)).to be_falsey
    #
    # ticket = Ticket.new(220)
    # umeda.enter(ticket)
    # expect(okamachi.exit(ticket)).to be_truthy
    #
    # # 梅田以外から乗車
    # ticket = Ticket.new(150)
    # juso.enter(ticket)
    # expect(okamachi.exit(ticket)).to be_falsey
    #
    # ticket = Ticket.new(180)
    # juso.enter(ticket)
    # expect(okamachi.exit(ticket)).to be_truthy
    #
    # # 上り
    # # 1区間
    # ticket = Ticket.new(150)
    # okamachi.enter(ticket)
    # expect(shonai.exit(ticket)).to be_truthy
    #
    # # 2区間
    # ticket = Ticket.new(150)
    # okamachi.enter(ticket)
    # expect(juso.exit(ticket)).to be_falsey
    #
    # ticket = Ticket.new(180)
    # okamachi.enter(ticket)
    # expect(juso.exit(ticket)).to be_truthy
    #
    # ticket = Ticket.new(220)
    # okamachi.enter(ticket)
    # expect(juso.exit(ticket)).to be_truthy
    #
    # # 3区間
    # ticket = Ticket.new(180)
    # okamachi.enter(ticket)
    # expect(umeda.exit(ticket)).to be_falsey
    #
    # ticket = Ticket.new(220)
    # okamachi.enter(ticket)
    # expect(umeda.exit(ticket)).to be_truthy
    #
    # # 岡町以外から乗車
    # ticket = Ticket.new(150)
    # shonai.enter(ticket)
    # expect(umeda.exit(ticket)).to be_falsey
    #
    # ticket = Ticket.new(180)
    # shonai.enter(ticket)
    # expect(umeda.exit(ticket)).to be_truthy
  end

  # NOTE: 以下のテストも同様に自分でコメントを外しながらテスト駆動開発を進めてください

  # context '同じ駅で降りる場合' do
  #   example 'エラーが発生する' do
  #     ticket = Ticket.new(150)
  #     umeda = Gate.new(:umeda)
  #     umeda.enter(ticket)
  #     expect { umeda.exit(ticket) }.to raise_error(ExitSameStationError)
  #   end
  # end
  #
  # context '改札を通った切符でもう一度入場する場合' do
  #   example 'エラーが発生する' do
  #     ticket = Ticket.new(150)
  #     umeda = Gate.new(:umeda)
  #     umeda.enter(ticket)
  #     expect { umeda.enter(ticket) }.to raise_error(AlreadyEnteredTicketError)
  #   end
  # end
  #
  # context '使用済みの切符でもう一度降りる場合' do
  #   example 'エラーが発生する' do
  #     ticket = Ticket.new(150)
  #     umeda = Gate.new(:umeda)
  #     juso = Gate.new(:juso)
  #     umeda.enter(ticket)
  #     expect(juso.exit(ticket)).to be_truthy
  #     expect { juso.exit(ticket) }.to raise_error(StaleTicketError)
  #   end
  # end
  #
  # context '改札を通っていない切符で降りる場合' do
  #   example 'エラーが発生する' do
  #     ticket = Ticket.new(150)
  #     umeda = Gate.new(:umeda)
  #     expect { umeda.exit(ticket) }.to raise_error(NotEnteredTicketError)
  #   end
  # end
end