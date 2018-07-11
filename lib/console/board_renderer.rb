require "colorize"

class BoardRenderer
  def initialize()
    @X = :light_blue
    @O = :green
  end

  def render(board)
    win_moves = board.winning_moves
    tile_strings = board.tiles.map { |tile| tile.to_s_with(colorize_tile(win_moves, tile.number)) }
    lines(tile_strings).join("\n")
  end

  private
  def colorize_tile(win_moves, tile_number)
    winning_tile = winning_tile?(win_moves, tile_number)
    lambda do |tile|
      return " #{colorize(tile, @X)} ".on_cyan if tile == :X and winning_tile 
      return " #{colorize(tile, @O)} ".on_light_green if tile == :O and winning_tile
      return " #{colorize(tile, @X)} " if tile == :X
      return " #{colorize(tile, @O)} " if tile == :O
      " #{tile.to_s} "
    end
  end

  def winning_tile?(win_moves, tile_number)
    win_moves.member?(tile_number)
  end

  def colorize(tile, color)
    tile.to_s.send(color)
  end

  def line_to_s(line)
    line.join("|")
  end

  def lines(tile_strings)
    tile_lines = tile_strings.each_slice(3).to_a
    tile_lines.map { |line| line_to_s(line) } 
  end
end
