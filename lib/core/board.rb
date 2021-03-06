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
      next_board(tile_number, player_symbol)
    else
      self
    end
  end

  def terminus_reached?
    full? || has_won?(:X) || has_won?(:O)
  end

  def full?
    tiles.all? { |tile| !tile.is_empty? }
  end

  def winning_moves
    moves = winning_combinations.find do |combination|
      winning_combination?(combination, :X) || winning_combination?(combination, :O)
    end
    moves || []
  end

  def has_won?(player_symbol)
    winning_combinations.any? do |combination|
      winning_combination?(combination, player_symbol)
    end
  end

  private
  def next_board(tile_number, player_symbol)
    Board.new(@board_size, next_tiles(tile_number, player_symbol))
  end

  def next_tiles(tile_number, player_symbol)
    tiles = copy_tiles
    mark_tile(tile_number, player_symbol, tiles)
    tiles
  end

  def mark_tile(tile_number, player_symbol, tiles)
    get_tile(tile_number, tiles).player_symbol = player_symbol
  end

  def available_tiles
    tiles.select { |tile| tile.is_empty? }
  end

  def winning_combination?(combination, player_symbol)
    combination.all? do |tile_number|
      tile = get_tile(tile_number, tiles)
      tile.player_symbol == player_symbol
    end
  end

  def get_tile(tile_number, tiles)
    tiles.find { |tile| tile.number == tile_number }
  end

  def winning_combinations
    [
      [1,2,3], [4,5,6], [7,8,9],
      [1,4,7], [2,5,8], [3,6,9],
      [1,5,9], [3,5,7]
    ]
  end

  def copy_tiles
    Marshal.load(Marshal.dump(tiles))
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
