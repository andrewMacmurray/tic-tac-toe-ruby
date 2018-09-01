class Minimax
  def initialize(options = {})
    @player = options[:player] || :O
    @opponent = options[:opponent] || :X
    @max_depth = 5
  end

  def run(board)
    scores(board)[0]
  end

  private
  def scores(board)
    move_scores = board.available_moves.map do |move|
      next_board = board.make_move(move, @opponent)
      [move, minimax(next_board)]
    end
    move_scores.max_by { |x| x[1] }
  end

  def minimax(board)
    minimize(board, 1)
  end

  def minimize(board, depth)
    return heuristic_value(board, depth) if terminus?(board, depth) 
    next_states(board, @opponent).map { |next_board| maximize(next_board, depth + 1) }.min
  end

  def maximize(board, depth)
    return heuristic_value(board, depth) if terminus?(board, depth) 
    next_states(board, @player).map { |next_board| minimize(next_board, depth + 1) }.max
  end

  def terminus?(board, depth)
    board.terminus_reached? || depth == @max_depth
  end

  def next_states(board, player)
    board.available_moves.map { |move| board.make_move(move, player) }
  end

  def heuristic_value(board, depth)
    return depth  if board.has_won?(@player)
    return -depth if board.has_won?(@opponent)
    return 0
  end
end
