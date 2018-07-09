require "console/messages"
require "console/board_renderer"

class Console
  def initialize(io)
    @io = io
    @board_renderer ||= BoardRenderer.new
    @messages ||= Messages.new
  end
  
  def request_move(board, player, oponent)
    move = get_move
    io.clear
    print_board_with_move(move, board, player)
    print_move_summary(move, player, oponent, board)
    move
  end

  def game_summary(board)
    io.clear
    print_board(board)
    print_terminus(board)
  end

  def greet_user
    print(messages.greet_user)
  end

  private
  attr_reader :board_renderer, :messages, :io

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
    print_draw    if board.full?
    print_win(:X) if board.has_won?(:X)
    print_win(:O) if board.has_won?(:O)
  end

  def print_move_summary(move, player, oponent, board)
    if board.valid_move?(move)
      print(messages.player_move(move, player))
      print(messages.player_turn(oponent))
    else
      print(messages.already_taken(move))
    end
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

  def print(message)
    io.puts(message)
  end
end
