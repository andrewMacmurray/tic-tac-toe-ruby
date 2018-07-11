class Tile
  attr_reader :number
  attr_accessor :player_symbol

  def initialize(number, player_symbol = :empty)
    @number = number
    @player_symbol = player_symbol
  end

  def is_empty?
    player_symbol == :empty
  end

  def to_s
    is_empty? ? number : player_symbol
  end

  def to_s_with(custom_to_s_lambda)
    custom_to_s_lambda.call(to_s)
  end
end
