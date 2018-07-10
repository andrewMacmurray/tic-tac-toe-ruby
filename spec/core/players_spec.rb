require "core/players/players"
require "core/board"
require "core/players/computer_player"
require "core/players/player"

describe Players do
  it "should get the current player smymbol" do
    players = make_players
    expect(players.current_player_symbol).to eq(:X)
  end

  it "switches the current player for the oponent" do
    players = make_players 
    players.switch
    expect(players.current_player_symbol).to eq(:O)
  end

  it "switches players back correctly" do
    players = make_players
    players.switch
    players.switch
    expect(players.current_player_symbol).to eq(:X)
  end

  it "requests a move from the current player" do
    p1 = ComputerPlayer.new(:X)
    p2 = ComputerPlayer.new(:O)
    players = make_players(p1, p2)
    board = Board.new
    
    expect(p1).to receive(:request_move).once.with(board)
    expect(p2).to_not receive(:request_move)

    players.request_move(board)
  end

  it "requests a move from the switched player" do
    p1 = HumanPlayer.new(:X, nil)
    p2 = HumanPlayer.new(:O, nil)
    players = make_players(p1, p2)
    board = Board.new

    expect(p1).to_not receive(:request_move)
    expect(p2).to receive(:request_move).once.with(board)

    players.switch
    players.request_move(board)
  end

  def make_players(p1 = Player.new(:X), p2 = Player.new(:O))
    Players.new(p1, p2)
  end

end
