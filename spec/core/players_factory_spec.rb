require "core/players/players_factory"
require "core/players/computer_player"
require "core/players/human_player"
require "console/console"

describe PlayersFactory do
  it "returns human v human players for option 1" do
    ui = build_ui
    players_factory = build_factory(ui)
    players = players_factory.create(1)

    expect(ui).to receive(:request_move).twice
    
    players.request_move(nil)
    players.switch
    players.request_move(nil)
  end

  it "returns human v computer players for option 2" do
    ui = build_ui
    players_factory = build_factory(ui)
    players = players_factory.create(2)
    board = build_board 

    expect(ui).to receive(:request_move).once

    players.request_move(board)
    players.switch
    players.request_move(board)
  end

  it "returns computer v computer players for option 3" do
    ui = build_ui
    players_factory = build_factory(ui)
    players = players_factory.create(3)
    board = build_board 

    expect(ui).to_not receive(:request_move)

    players.request_move(board)
    players.switch
    players.request_move(board)
  end

  def build_factory(ui)
    PlayersFactory.new(ui)
  end

  def build_ui
    Console.new(nil)
  end

  def build_board
    Board.new
      .make_move(1, :X)
      .make_move(2, :O)
      .make_move(3, :X)
      .make_move(4, :O)
  end
end
