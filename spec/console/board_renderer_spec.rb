require "colorize"
require "console/board_renderer"
require "core/board"

describe BoardRenderer do
  let(:x) { "X".light_blue }
  let(:o) { "O".green }

  it "should turn a board into renderable lines" do
    board = Board.new
    board_renderer = BoardRenderer.new

    actual_lines = board_renderer.render(board)
    expected_lines = [
      "1 | 2 | 3",
      "4 | 5 | 6",
      "7 | 8 | 9"
    ].join("\n")

    expect(actual_lines).to eq(expected_lines)
  end

  it "should render player moves with default colors correctly on a board" do
    board_renderer = BoardRenderer.new
    player_1 = :X
    player_2 = :O 


    board = Board.new
      .make_move(1, player_1)
      .make_move(3, player_2)

    actual_lines = board_renderer.render(board)
    expected_lines = [
      "#{x} | 2 | #{o}",
      "4 | 5 | 6",
      "7 | 8 | 9"
    ].join("\n")

    expect(actual_lines).to eq(expected_lines)
  end
end
