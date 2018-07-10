require "core/board"
require "core/players/human_player"
require "console/console"
require "console/console_io"

describe HumanPlayer do
  it "has correct symbol" do
    player = HumanPlayer.new(:X, build_ui)
    expect(player.symbol).to eq(:X)
  end

  it "requests a move via the ui" do
    ui = build_ui("3")
    player = HumanPlayer.new(:X, ui) 
    board = Board.new

    move = player.request_move(board)

    expect(move).to eq(3)
  end

  def build_ui(input = "")
    Console.new(
      ConsoleIO.new(
        input: StringIO.new(input),
        output: StringIO.new
      )
    )
  end
end
