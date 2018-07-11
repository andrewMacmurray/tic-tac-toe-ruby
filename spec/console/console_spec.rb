require "console/console"
require "core/players/player"
require "core/players/players"
require "console/board_renderer"
require "console/messages"
require "console/console_io"
require "core/board"

describe Console do
  let(:messages) { Messages.new }
  let(:board_renderer) { BoardRenderer.new }
  let(:clear_sequence) { "\e[H\e[2J" }

  it "requests a move from user" do
    console = build_console(StringIO.new, StringIO.new("3"))

    move = console.request_move

    expect(move).to eq(3)
  end

  it "prints a summary for a move" do
    output = build_output
    console = build_console(output)
    board = Board.new

    console.move_summary(3, board, :X, :O)

    expected_output = [
      clear_sequence + board_renderer.render(board.make_move(3, :X)),
      messages.player_move(3, :X),
      messages.player_turn(:O)
    ].join("\n") + "\n"

    expect(output.string).to eq(expected_output)
  end

  it "renders the result of an invalid move" do
    output  = build_output
    console = build_console(output) 
    board = Board.new.make_move(3, :X)

    console.move_summary(3, board, :X, :O)

    expected_output = [
      clear_sequence + board_renderer.render(board),
      messages.already_taken(3)
    ].join("\n") + "\n"

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

  it "displays win correctly when board is full" do
    output = build_output
    console = build_console(output)
    board = build_full_winning_board

    console.game_summary(board) 

    expected_output = [
      clear_sequence + board_renderer.render(board),
      messages.player_win(:X)
    ].join("\n") + "\n"

    expect(output.string).to eq(expected_output)
  end

  it "prompts user for game choice, returns players" do
    output = build_output
    console = build_console(output, StringIO.new("1"))
    players_factory = PlayersFactory.new(console)

    expect(players_factory).to receive(:create).once.with(1).and_return(build_players)

    console.get_players(players_factory)

    expected_output = [
      messages.options.join("\n"),
      messages.prompt + messages.instructions(:X)
    ].join("\n") + "\n"

    expect(output.string).to eq(expected_output)
  end

  it "retries until it valid game option received" do
    output = build_output
    console = build_console(output, StringIO.new("blah\n9\n3"))
    players_factory = PlayersFactory.new(console)

    expect(players_factory).to receive(:create).once.with(3).and_return(build_players)

    console.get_players(players_factory)
    
    expect(output.string).to include(messages.unrecognised)
  end

  def build_console(output, input = StringIO.new)
    console_io = ConsoleIO.new(input: input, output: output)
    Console.new(console_io)
  end

  def build_output
    StringIO.new
  end

  def build_draw_board
    run_board([1, 2, 3, 5, 8, 4, 6, 9, 7])
  end

  def build_full_winning_board
    run_board([1, 2, 3, 4, 5, 6, 8, 7, 9])
  end

  def run_board(sequence)
    board = Board.new
    players = build_players
    sequence.each do |move|
      board = board.make_move(move, players.current_player_symbol)
      players.switch
    end
    board
  end

  def build_players
    Players.new(Player.new(:X), Player.new(:O))
  end
end
