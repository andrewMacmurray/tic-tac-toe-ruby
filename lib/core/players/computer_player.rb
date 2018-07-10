require "core/players/player"
require "core/players/minimax"

class ComputerPlayer < Player
  def initialize(symbol)
    super(symbol)
    @minimax = build_minimax
  end

  def request_move(board)
    @minimax.run(board)
  end

  private
  def build_minimax
    Minimax.new(player: self.symbol, oponent: self.oponent)
  end
end
