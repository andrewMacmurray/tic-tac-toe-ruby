require "core/tile"

class Board
  attr_reader :board_size
  attr_reader :tiles

  def initialize(board_size = 3) 
    @board_size = board_size
    @tiles = create_tiles
  end

  def available_moves
    available_tiles.map { |tile| tile.number }
  end

  def make_move(tile_number, player_symbol)
    tile = get_tile(tile_number) 
    tile.player_symbol = player_symbol unless tile.nil?
  end

  def terminus_reached?
    is_full? || has_won?(:X) || has_won?(:O)
  end

  def is_full?
    tiles.all? { |tile| !tile.is_empty? }
  end

  def has_won?(player_symbol)
    winning_combinations.any? do |combination|
      has_winning_combination?(combination, player_symbol)
    end
  end

  private
  def available_tiles
    tiles.select { |tile| tile.is_empty? }
  end

  def has_winning_combination?(combination, player_symbol)
    combination.all? do |tile_number|
      tile = get_tile(tile_number)
      tile.player_symbol == player_symbol
    end
  end

  def get_tile(tile_number)
    tiles.find { |tile| tile.number == tile_number }
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
