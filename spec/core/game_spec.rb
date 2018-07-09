require "core/game"
require "core/board"
require "core/players/players"
require "core/players/player"

describe Game do
  let(:players) {
    Players.new(
      Player.new(:X),
      Player.new(:O)
    )
  }

  it "plays a winning game correctly" do
    ui = ui_stub([1, 4, 2, 5, 3])

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
    ui = ui_stub([1, 2, 3, 5, 8, 4, 6, 9, 7])

    game = Game.new(
      board: Board.new,
      players: players,
      ui: ui
    )

    expect(ui).to receive(:print_draw).once
    expect(ui).to_not receive(:print_win)

    game.play
  end

  def ui_stub(move_sequence)
    ui = Console.new(ConsoleIO.new(input: StringIO.new, output: StringIO.new))
    allow(ui).to receive(:get_move) { move_sequence.shift }
    allow(ui).to receive(:print_win)
    allow(ui).to receive(:print_draw)
    ui
  end
end
