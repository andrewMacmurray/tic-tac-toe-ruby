require "tile"

class Board
  attr_reader :board_size

  def initialize(board_size = 3) 
    @board_size = board_size
    @tiles = create_tiles
  end

  def available_moves
    available_tiles.map { |tile| tile.number }
  end

  def make_move(tile_number, player)
    tile = get_tile(tile_number) 
    tile.player_symbol = player.symbol unless tile.nil?
  end

  def is_full?
    tiles.all? { |t| !t.is_empty? }
  end

  def has_won?(player)
    winning_combinations.any? { |c| has_winning_combination?(c, player) }
  end

  def tiles
    @tiles
  end

  private
  def available_tiles
    tiles.select { |tile| tile.is_empty? }
  end

  def has_winning_combination?(combination, player)
    combination.all? do |c|
      tile = get_tile(c)
      tile.player_symbol == player.symbol
    end
  end

  def get_tile(tile_number)
    tiles.find { |t| t.number == tile_number }
  end

  def winning_combinations
    [
      [1,2,3], [4,5,6], [7,8,9],
      [1,4,7], [2,5,8], [3,5,9],
      [1,5,9], [3,5,7]
    ]
  end

  def create_tiles
    indicies = 1..(board_size * board_size)
    indicies.map do |number|
      Tile.new(number)
    end
  end
end
