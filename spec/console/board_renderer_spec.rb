require "console/board_renderer"
require "core/board"

describe BoardRenderer do
  it "should turn a board into renderable lines" do
    board = Board.new
    board_renderer = BoardRenderer.new

    expected_lines = [
      "1 | 2 | 3",
      "4 | 5 | 6",
      "7 | 8 | 9"
    ].join("\n")

    actual_lines = board_renderer.render(board)
    expect(actual_lines).to eq(expected_lines)
  end

  it "should render player moves correctly on a board" do
    board_renderer = BoardRenderer.new
    player_1 = :X
    player_2 = :O 


    board = Board.new
    board.make_move(1, player_1)
    board.make_move(3, player_2)

    expected_lines = [
      "X | 2 | O",
      "4 | 5 | 6",
      "7 | 8 | 9"
    ].join("\n")

    actual_lines = board_renderer.render(board)
    expect(actual_lines).to eq(expected_lines)
  end
end
