require "colorize"
require "console/board_renderer"
require "core/board"

describe BoardRenderer do
  let(:x) { " X ".light_blue }
  let(:o) { " O ".green }
  let(:board_renderer) { BoardRenderer.new }

  it "converts a board into renderable lines" do
    board = Board.new
    actual_lines = board_renderer.render(board)
    expected_lines = [
      " 1 | 2 | 3 ",
      " 4 | 5 | 6 ",
      " 7 | 8 | 9 "
    ].join("\n")

    expect(actual_lines).to eq(expected_lines)
  end

  it "renders player moves with default colors correctly on a board" do
    player_1 = :X
    player_2 = :O 
    board = Board.new
      .make_move(1, player_1)
      .make_move(3, player_2)

    actual_lines = board_renderer.render(board)
    expected_lines = [
      "#{x}| 2 |#{o}",
      " 4 | 5 | 6 ",
      " 7 | 8 | 9 "
    ].join("\n")

    expect(actual_lines).to eq(expected_lines)
  end

  it "renders a winning line for X correctly" do
    board = Board.new
      .make_move(1, :X)
      .make_move(2, :X)
      .make_move(3, :X)

    x_win = x.on_cyan
    actual_lines = board_renderer.render(board)
    expected_lines = [
      "#{x_win}|#{x_win}|#{x_win}",
      " 4 | 5 | 6 ",
      " 7 | 8 | 9 "
    ].join("\n")
    
    expect(actual_lines).to eq(expected_lines)
  end

  it "renders a winning line for O correctly" do
    board = Board.new
      .make_move(1, :O)
      .make_move(5, :O)
      .make_move(9, :O)

    o_win = o.on_light_green
    actual_lines = board_renderer.render(board)
    expected_lines = [
      "#{o_win}| 2 | 3 ",
      " 4 |#{o_win}| 6 ",
      " 7 | 8 |#{o_win}"
    ].join("\n")

    expect(actual_lines).to eq(expected_lines)
  end

  it "renders board with emojis as tiles" do
    x = "✨"
    o = "👾"
    player_symbols = {:X => x, :O => o}
    board_renderer.set_player_emojis(player_symbols)

    board = Board.new.make_move(1, :X).make_move(5, :O)
    actual_lines = board_renderer.render(board)
    expected_lines = [
      " #{x} | 2  | 3  ",
      " 4  | #{o} | 6  ",
      " 7  | 8  | 9  "
    ].join("\n")
    print actual_lines

    expect(actual_lines).to eq(expected_lines)
  end
end
