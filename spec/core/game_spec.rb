require "core/game"
require "core/board"
require "core/players/players"
require "core/players/human_player"
require "console/console"
require "console/console_io"

describe Game do
  it "prompts the user for game options" do
    ui = ui_stub
    board = Board.new
    game = Game.new(
      board: board,
      players_factory: factory_stub([1, 4, 2, 5, 3], ui),
      ui: ui
    )
    
    expect(ui).to receive(:use_emojis).once
    expect(ui).to receive(:game_choice).once
    expect(ui).to receive(:game_instructions).once.with(:X, board)

    game.play
  end

  it "requests a player option from the user" do
    ui = ui_stub
    players_factory = factory_stub([1, 4, 2, 5, 3], ui)

    game = Game.new(
      board: Board.new,
      players_factory: players_factory,
      ui: ui
    )

    expect(players_factory).to receive(:create).once.with(1)

    game.play
  end

  it "plays a winning game correctly" do
    ui = ui_stub
    players = factory_stub([1, 4, 2, 5, 3], ui)

    game = Game.new(
      board: Board.new,
      players_factory: players,
      ui: ui
    )

    expect(ui).to_not receive(:print_draw)
    expect(ui).to receive(:print_win).once.with(:X)

    game.play
  end

  it "plays until a draw" do
    ui = ui_stub
    players = factory_stub([1, 2, 3, 5, 8, 4, 6, 9, 7], ui)

    game = Game.new(
      board: Board.new,
      players_factory: players,
      ui: ui
    )

    expect(ui).to receive(:print_draw).once
    expect(ui).to_not receive(:print_win)

    game.play
  end

  def ui_stub
    ui = Console.new(ConsoleIO.new(input: StringIO.new("1\nN"), output: StringIO.new))
    allow(ui).to receive(:print_win)
    allow(ui).to receive(:print_draw)
    ui
  end

  def factory_stub(move_sequence, ui)
    factory = PlayersFactory.new(ui)
    allow(factory).to receive(:create) { players_stub(move_sequence, ui) }
    factory
  end

  def players_stub(move_sequence, ui)
    players = build_players(ui)
    allow(players).to receive(:request_move) { move_sequence.shift }
    players
  end

  def build_players(ui)
    Players.new(
      HumanPlayer.new(:X, ui),
      HumanPlayer.new(:O, ui)
    )
  end
end
