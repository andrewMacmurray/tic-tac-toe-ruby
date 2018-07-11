require "colorize"

class BoardRenderer
  def initialize()
    @x_colors = {:color => :light_blue, :background => :on_cyan}
    @o_colors = {:color => :green,      :background => :on_light_green}
  end

  def render(board)
    lines(tile_strings(board)).join("\n")
  end

  private
  def tile_strings(board)
    win_moves = board.winning_moves
    board.tiles.map do |tile|
      colorized = colorize_tile(win_moves, tile.number)
      tile.to_s_with(colorized)
    end
  end

  def colorize_tile(win_moves, tile_number)
    win_tile = winning_tile?(win_moves, tile_number)
    lambda do |tile|
      return winning_tile(tile, @x_colors) if tile == :X and win_tile 
      return winning_tile(tile, @o_colors) if tile == :O and win_tile
      return player_tile(tile,  @x_colors) if tile == :X
      return player_tile(tile,  @o_colors) if tile == :O
      pad(tile.to_s)
    end
  end

  def winning_tile(tile, player_colors)
    inner_tile = player_tile(tile, player_colors)
    colorize(inner_tile, player_colors[:background])
  end

  def player_tile(tile, player_colors)
    pad(colorize(tile, player_colors[:color]))
  end

  def winning_tile?(win_moves, tile_number)
    win_moves.member?(tile_number)
  end

  def pad(tile)
    " #{tile} "
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
