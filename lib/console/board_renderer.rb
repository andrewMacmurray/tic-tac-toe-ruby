require "colorize"

class BoardRenderer
  def initialize()
    @emojis   = false
    @x_config = {
      :color      => :light_blue,
      :background => :on_cyan,
      :tile       => "X"
    }
    @o_config = {
      :color      => :green,
      :background => :on_light_green,
      :tile       => "O"
    }
  end

  def render(board)
    lines(tile_strings(board)).join("\n")
  end

  def set_player_emojis(emojis)
    @x_config[:tile] = emojis[:X]
    @o_config[:tile] = emojis[:O]
    @emojis          = true
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
      return winning_tile(tile, @x_config) if tile == :X and win_tile 
      return winning_tile(tile, @o_config) if tile == :O and win_tile
      return player_tile(tile,  @x_config) if tile == :X
      return player_tile(tile,  @o_config) if tile == :O
      pad(tile.to_s)
    end
  end

  def winning_tile(tile, player_config)
    inner_tile = player_tile(tile, player_config)
    colorize(inner_tile, player_config[:background])
  end

  def player_tile(tile, player_config)
    if @emojis
      player_config[:tile].center(3)
    else
      t = pad(player_config[:tile])
      colorize(t, player_config[:color])
    end
  end

  def winning_tile?(win_moves, tile_number)
    win_moves.member?(tile_number)
  end

  def pad(tile)
    return tile.center(4) if @emojis
    return tile.center(3)
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
