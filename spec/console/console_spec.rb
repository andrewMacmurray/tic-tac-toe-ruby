require "console/console"
require "console/board_renderer"
require "console/messages"
require "core/board"

describe Console do
  let(:messages) { Messages.new }
  let(:board_renderer) { BoardRenderer.new }

  it "greets the user" do
    output = build_output
    console = build_console(output)
    expected_output = messages.greet_user + "\n"

    console.greet_user
    
    expect(output.string).to eq(expected_output)
  end

  it "shows the game options to the user" do
    output = build_output
    console = build_console(output)
    expected_output = messages.options.join("\n") + "\n"

    console.show_options

    expect(output.string).to eq(expected_output)
  end

  it "shows a summary for a given move" do
    output = build_output
    console = build_console(output)
    expected_output = [
      messages.player_move(1, :X),
      messages.player_turn(:O)
    ].join("\n") + "\n"

    console.show_move_summary(1, :X, :O)

    expect(output.string).to eq(expected_output)
  end

  it "instructs the user to enter a number" do
    output = build_output
    console = build_console(output)
    expected_output = messages.instructions(:X) + "\n"

    console.show_instructions(:X)

    expect(output.string).to eq(expected_output)
  end

  it "shows a given board" do
    board = Board.new
    output = build_output
    console = build_console(output)
    expected_output = board_renderer.render(board) + "\n"

    console.show_board(board)

    expect(output.string).to eq(expected_output) 
  end

  it "gets a move from the user" do
    console = build_console_with_input("3", build_output)

    move = console.get_move

    expect(move).to eq(3)
  end

  it "prints message for a player win" do
    output = build_output
    console = build_console(output)
    expected_output = messages.player_win(:X) + "\n"

    console.show_win(:X)

    expect(output.string).to eq(expected_output)
  end

  it "prints message for draw" do
    output = build_output
    console = build_console(output)
    expected_output = messages.draw + "\n"

    console.show_draw

    expect(output.string).to eq(expected_output)
  end

  def build_console(output)
    Console.new(
      input: empty_input,
      output: output
    )
  end

  def build_console_with_input(input_value, output)
    Console.new(
      input: build_input(input_value),
      output: output
    )
  end

  def empty_input
    StringIO.new
  end

  def build_input(input)
    StringIO.new(input)
  end

  def build_output
    StringIO.new
  end
end
