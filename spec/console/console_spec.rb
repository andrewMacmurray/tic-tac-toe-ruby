require "console/console"
require "console/board_renderer"
require "console/messages"
require "core/board"

describe Console do
  let(:messages) { Messages.new }
  let(:board_renderer) { BoardRenderer.new }
  let(:clear_sequence) { "\e[H\e[2J" }

  it "requests a move from a player and renders its result" do
    output = build_output
    console = build_console_with_input("3", output)
    board = Board.new

    move = console.request_move(board, :X, :O)

    expected_output = [
      clear_sequence + board_renderer.render(board.make_move(3, :X)),
      messages.player_move(3, :X),
      messages.player_turn(:O)
    ].join("\n") + "\n"

    expect(move).to eq(3)
    expect(output.string).to eq(expected_output)
  end

  it "renders the result of an invalid move" do
    output  = build_output
    console = build_console_with_input("3", output)
    board = Board.new.make_move(3, :X)

    move = console.request_move(board, 3, :O)

    expected_output = [
      clear_sequence + board_renderer.render(board),
      messages.already_taken(move)
    ].join("\n") + "\n"

    expect(move).to eq(3)
    expect(output.string).to eq(expected_output)
  end

  it "displays the result of a winning game" do
    output = build_output
    console = build_console(output)

    board = Board.new
      .make_move(1, :X)
      .make_move(2, :X)
      .make_move(3, :X)

    console.game_summary(board)

    expected_output = [
      clear_sequence + board_renderer.render(board),
      messages.player_win(:X)
    ].join("\n") + "\n"

    expect(output.string).to eq(expected_output)
  end

  it "displays the result of a draw" do
    output = build_output
    console = build_console(output)
    board = build_draw_board

    console.game_summary(board) 

    expected_output = [
      clear_sequence + board_renderer.render(board),
      messages.draw
    ].join("\n") + "\n"

    expect(output.string).to eq(expected_output)
  end

  def build_console(output)
    console_io = ConsoleIO.new(input: StringIO.new, output: output)
    Console.new(console_io)
  end

  def build_console_with_input(input_value, output)
    console_io = ConsoleIO.new(input: build_input(input_value), output: output)
    Console.new(console_io)
  end

  def build_input(input)
    StringIO.new(input)
  end

  def build_output
    StringIO.new
  end

  def build_draw_board
    board = Board.new
    players = Players.new(Player.new(:X), Player.new(:O))
    draw_sequence = [1, 2, 3, 5, 8, 4, 6, 9, 7]

    draw_sequence.each do |move|
      board = board.make_move(move, players.current_player_symbol)
      players.switch
    end

    board
  end
end
