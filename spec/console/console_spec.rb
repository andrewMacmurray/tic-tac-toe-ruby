require "console/console"
require "console/board_ui"
require "console/messages"
require "board"

describe Console do
  let(:board_ui) { BoardUI.new }
  let(:messages) { Messages.new }

  it "greets the user" do
    output = StringIO.new
    console = Console.new(output: output, board_ui: board_ui, messages: messages)

    console.greet_user
    
    expected_output = messages.greet_user + "\n"
    expect(output.string).to eq(expected_output)
  end

  it "shows the game options to the user" do
    output = StringIO.new
    console = Console.new(output: output, board_ui: board_ui, messages: messages)

    console.show_options

    expected_output = messages.options.join("\n") + "\n"
    expect(output.string).to eq(expected_output)
  end

  it "shows a summary for a given move" do
    output = StringIO.new
    console = Console.new(output: output, board_ui: board_ui, messages: messages)

    player = PlayerSymbol.new(:X)
    console.show_move_summary(1, player)

    expected_output = [
      messages.player_move(1, :X),
      messages.player_turn(:O)
    ].join("\n") + "\n"

    expect(output.string).to eq(expected_output)
  end

  it "prints a given board" do
    output = StringIO.new
    console = Console.new(output: output, board_ui: board_ui, messages: messages)
    board = Board.new(3)

    console.print_board(board)

    expected_output = board_ui.render(board) + "\n"
    expect(output.string).to eq(expected_output) 
  end
end
