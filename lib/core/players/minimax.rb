class Minimax
  def initialize(options = {})
    @player = options[:player] || :O
    @oponent = options[:oponent] || :X
    @max_depth = 5
  end

  def run(board)
    scores(board)[0]
  end

  private
  def scores(board)
    xs = board.available_moves.map do |move|
      next_board = board.make_move(move, @oponent)
      [move, minimax(next_board)]
    end
    xs.max_by { |x| x[1] }
  end

  def minimax(board)
    minimize(board, 1)
  end

  def minimize(board, depth)
    if board.terminus_reached? || depth == @max_depth
      heuristic_value(board, depth)
    else
      xs = board.available_moves.map do |move|
        next_board = board.make_move(move, @oponent)
        maximize(next_board, depth + 1)
      end
      xs.min
    end
  end

  def maximize(board, depth)
    if board.terminus_reached? || depth == @max_depth
      heuristic_value(board, depth)
    else
      xs = board.available_moves.map do |move|
        next_board = board.make_move(move, @player)
        minimize(next_board, depth + 1)
      end
      xs.max
    end
  end

  def heuristic_value(board, depth)
    if board.has_won?(@player)
      depth
    elsif board.has_won?(@oponent)
      -depth
    else
      0
    end
  end
end
