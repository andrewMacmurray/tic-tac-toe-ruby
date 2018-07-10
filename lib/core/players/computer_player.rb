require "core/players/player"
require "core/players/minimax"

class ComputerPlayer < Player
  def initialize(symbol)
    super(symbol)
    @minimax = build_minimax
  end

  def request_move(board)
    strategic_move(board)
  end

  private
  def strategic_move(board)
    return first_move(board)  if moves(board) == 9
    return second_move(board) if moves(board) == 8
    run_minimax(board)
  end

  def moves(board)
    board.available_moves.length
  end

  def second_move(board)
    board.valid_move?(5) ? 5 : run_minimax(board)
  end

  def first_move(board)
    board.valid_move?(1) ? 1 : 5
  end

  def run_minimax(board)
    @minimax.run(board)
  end

  def build_minimax
    Minimax.new(player: self.symbol, oponent: self.oponent)
  end
end
