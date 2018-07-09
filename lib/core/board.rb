require "core/tile"

class Board
  attr_reader :board_size
  attr_reader :tiles

  def initialize(board_size = 3, tiles = []) 
    @board_size = board_size
    @tiles = handle_create_tiles(tiles)
  end

  def available_moves
    available_tiles.map { |tile| tile.number }
  end

  def valid_move?(move)
    available_moves.include?(move) && !get_tile(move, tiles).nil?
  end

  def make_move(tile_number, player_symbol)
    if valid_move?(tile_number)
      new_tiles = copy_tiles
      tile = get_tile(tile_number, new_tiles) 
      tile.player_symbol = player_symbol 
      Board.new(3, new_tiles)
    else
      self
    end
  end

  def terminal?
    full? || has_won?(:X) || has_won?(:O)
  end

  def full?
    tiles.all? { |t| !t.is_empty? }
  end

  def has_won?(player_symbol)
    winning_combinations.any? { |c| has_winning_combination?(c, player_symbol) }
  end

  private
  def available_tiles
    tiles.select { |tile| tile.is_empty? }
  end

  def has_winning_combination?(combination, player_symbol)
    combination.all? do |c|
      tile = get_tile(c, tiles)
      tile.player_symbol == player_symbol
    end
  end

  def get_tile(tile_number, ts)
    ts.find { |t| t.number == tile_number }
  end

  def winning_combinations
    [
      [1,2,3], [4,5,6], [7,8,9],
      [1,4,7], [2,5,8], [3,5,9],
      [1,5,9], [3,5,7]
    ]
  end

  def copy_tiles
    tiles.map do |tile|
      Tile.new(tile.number, tile.player_symbol)
    end
  end

  def handle_create_tiles(tiles)
    tiles.length > 0 ? tiles : create_new_tiles
  end

  def create_new_tiles
    indicies = 1..(board_size * board_size)
    indicies.map do |number|
      Tile.new(number)
    end
  end
end
