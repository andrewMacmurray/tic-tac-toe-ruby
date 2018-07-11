require "console/messages"
require "console/board_renderer"

class Console
  def initialize(io)
    @io = io
    @board_renderer ||= BoardRenderer.new
    @messages ||= Messages.new
  end

  def greet_user
    print(messages.greet_user)
  end

  def get_players(players_factory)
    print_options
    prompt
    players = players_factory.create(get_game_choice)
    game_instructions(players.current_player_symbol)
    players
  end

  def request_move(board = nil)
    prompt
    get_move
  end

  def move_summary(move, board, player, opponent)
    clear_screen
    print_board_with_move(move, board, player)
    print_move_summary(move, player, opponent, board)
  end

  def game_summary(board)
    clear_screen
    print_board(board)
    print_terminus(board)
  end

  private
  attr_reader :board_renderer, :messages, :io
  def game_instructions(player)
    print(messages.instructions(player))
  end
  
  def print_board_with_move(move, board, player)
    if board.valid_move?(move)
      print_board(board.make_move(move, player))
    else
      print_board(board)
    end
  end

  def print_board(board)
    board_string = board_renderer.render(board)
    print(board_string)
  end

  def print_terminus(board)
    return print_win(:X) if board.has_won?(:X)
    return print_win(:O) if board.has_won?(:O)
    return print_draw    if board.full?
  end

  def print_move_summary(move, player, opponent, board)
    if board.valid_move?(move)
      print(messages.player_move(move, player))
      print(messages.player_turn(opponent))
    else
      print(messages.already_taken(move))
    end
  end

  def print_options
    messages.options.each { |option| print(option) }
  end

  def clear_screen
    io.clear
  end

  def prompt
    io.print(messages.prompt)
  end

  def print_win(player)
    print(messages.player_win(player))
  end

  def print_draw
    print(messages.draw)
  end

  def get_move
    io.read_int_in_range(1, 9)
  end

  def get_game_choice
    io.read_int_in_range(1, 3)
  end

  def print(message)
    io.puts(message)
  end
end
