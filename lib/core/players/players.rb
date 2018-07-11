class Players
  def initialize(player_1, player_2)
    @current_player = player_1
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player_symbol
    current_player.symbol
  end

  def request_move(board)
    current_player.request_move(board)
  end

  def current_opponent_symbol
    if current_player.symbol == player_1.symbol
      player_2.symbol
    else
      player_1.symbol
    end
  end

  def switch
    if current_player.symbol == player_1.symbol
      self.current_player = player_2
    else
      self.current_player = player_1
    end
  end

  private
  attr_accessor :current_player
  attr_reader :player_1
  attr_reader :player_2
end
