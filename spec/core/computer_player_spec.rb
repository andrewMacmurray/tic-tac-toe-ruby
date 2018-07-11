require "core/players/computer_player"
require "console/console"
require "console/console_io"
require "console/messages"

describe ComputerPlayer do
  let(:messages) { Messages.new }
  it "has correct symbol" do
    player = ComputerPlayer.new(:X)
    expect(player.symbol).to eq(:X)
  end

  it "takes top left corner on the first move" do
    player = ComputerPlayer.new(:X)
    board = Board.new

    expect(player.request_move(board)).to eq(1)
  end

  it "takes the centre on the second move if not already taken" do
    player = ComputerPlayer.new(:X)
    board = Board.new.make_move(1, :O)

    expect(player.request_move(board)).to eq(5)
  end

  it "takes the top left if centre is taken on the second move" do
    player = ComputerPlayer.new(:X)
    board = Board.new.make_move(5, :O)

    expect(player.request_move(board)).to eq(1)
  end

  it "computer makes a move" do
    player = ComputerPlayer.new(:X)
    board = Board.new
      .make_move(1, :O)
      .make_move(5, :X)
      .make_move(7, :O)

    expect(player.request_move(board)).to eq(4)
  end
end
