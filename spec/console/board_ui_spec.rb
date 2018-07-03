require "console/board_ui"
require "player_symbol"
require "board"

describe BoardUI do
  it "should turn a board into renderable lines" do
    board = Board.new(3)
    board_ui = BoardUI.new

    expected_lines = [
      "1 | 2 | 3",
      "4 | 5 | 6",
      "7 | 8 | 9"
    ].join("\n")

    actual_lines = board_ui.render(board)
    expect(actual_lines).to eq(expected_lines)
  end

  it "should render player moves correctly on a board" do
    board_ui = BoardUI.new
    player_1 = PlayerSymbol.new(:X)
    player_2 = PlayerSymbol.new(:O)


    board = Board.new(3)
    board.make_move(1, player_1)
    board.make_move(3, player_2)

    expected_lines = [
      "X | 2 | O",
      "4 | 5 | 6",
      "7 | 8 | 9"
    ].join("\n")

    actual_lines = board_ui.render(board)
    expect(actual_lines).to eq(expected_lines)
  end
end
