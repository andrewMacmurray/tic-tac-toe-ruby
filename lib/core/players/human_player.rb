require "core/players/player"

class HumanPlayer < Player
  def initialize(symbol, ui)
    super(symbol)
    @ui = ui
  end

  def request_move(board)
    @ui.request_move(board)
  end
end
