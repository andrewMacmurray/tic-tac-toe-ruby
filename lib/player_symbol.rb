class PlayerSymbol
  attr_reader :symbol

  def initialize(player_symbol)
    @symbol = player_symbol
  end

  def oponent
    symbol == :X ? :O : :X
  end
end
