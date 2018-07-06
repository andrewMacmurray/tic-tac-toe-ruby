require "core/game"
require "core/players/players"
require "core/players/player"

describe Game do
  it "plays a winning game correctly" do
    players = Players.new(
      Player.new(:X),
      Player.new(:O)
    ) 
    move_sequence = [1, 4, 2, 5, 3]
    board = Board.new(3)
    ui = ui_spy(move_sequence)
    game = Game.new(
      board: board,
      players: players,
      ui: ui
    )

    game.play

    expect(board.is_terminal?).to be(true)
    expect(board.has_won?(:X)).to be(true)
  end

  it "plays until a draw" do
    players = Players.new(
      Player.new(:X),
      Player.new(:O)
    )
    move_sequence = [1, 2, 3, 5, 8, 4, 6, 9, 7]
    board = Board.new(3)
    ui = ui_spy(move_sequence)
    game = Game.new(
      board: board,
      players: players,
      ui: ui
    )

    game.play

    expect(board.is_terminal?).to be(true)
    expect(board.is_full?).to be(true)
  end

  def ui_spy(move_sequence)
    ui = spy()
    allow(ui).to receive(:get_move) { move_sequence.shift }
    allow(ui).to receive(:show_win)
    allow(ui).to receive(:show_draw)

    expect(ui).to receive(:greet_user).once
    expect(ui).to receive(:clear).at_least(move_sequence.length)
    expect(ui).to receive(:show_board).at_least(move_sequence.length)
    expect(ui).to receive(:show_move_summary).at_least(move_sequence.length)
    ui
  end
end
