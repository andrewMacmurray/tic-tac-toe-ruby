require "core/game"
require "core/board"
require "core/players/players"
require "core/players/human_player"
require "console/console"
require "console/console_io"

describe Game do
  it "plays a winning game correctly" do
    ui = ui_stub
    players = players_stub([1, 4, 2, 5, 3], ui)

    game = Game.new(
      board: Board.new,
      players: players,
      ui: ui
    )

    expect(ui).to_not receive(:print_draw)
    expect(ui).to receive(:print_win).once.with(:X)

    game.play
  end

  it "plays until a draw" do
    ui = ui_stub
    players = players_stub([1, 2, 3, 5, 8, 4, 6, 9, 7], ui)

    game = Game.new(
      board: Board.new,
      players: players,
      ui: ui
    )

    expect(ui).to receive(:print_draw).once
    expect(ui).to_not receive(:print_win)

    game.play
  end

  def ui_stub
    ui = Console.new(ConsoleIO.new(input: StringIO.new, output: StringIO.new))
    allow(ui).to receive(:print_win)
    allow(ui).to receive(:print_draw)
    ui
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
