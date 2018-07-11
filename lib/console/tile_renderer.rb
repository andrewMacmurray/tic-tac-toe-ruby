require "colorize"
require "console/tile_config"

class TileRenderer
  def initialize
    @emojis   = false
    @x_config = TileConfig.new(:X, "✨")
    @o_config = TileConfig.new(:O, "👾") 
  end

  def render(tile, win_moves)
    tile.to_s_with(colorize_tile(tile.number, win_moves))
  end

  def toggle_emojis(on)
    on ? emojis_on : emojis_off
  end

  private
  def colorize_tile(tile_number, win_moves)
    is_win_tile = win_moves.member?(tile_number)
    lambda do |tile|
      return winning_tile(@x_config) if tile == :X and is_win_tile
      return winning_tile(@o_config) if tile == :O and is_win_tile
      return player_tile(@x_config)  if tile == :X
      return player_tile(@o_config)  if tile == :O
      return add_padding(tile.to_s)
    end
  end

  def winning_tile(config)
    inner_tile = player_tile(config)
    colorize(inner_tile, config.background)
  end

  def player_tile(config)
    symbol = config.tile_symbol
    return pad(symbol, 3) if @emojis
    return standard_colorize(symbol, config.color)
  end

  def standard_colorize(tile_symbol, color)
    colorize(add_padding(tile_symbol), color)
  end

  def colorize(tile, color)
    tile.to_s.send(color)
  end

  def add_padding(tile)
    return pad(tile, 4) if @emojis
    return pad(tile, 3)
  end

  def pad(tile, n)
    tile.center(n)
  end

  def emojis_on
    @emojis = true
    @x_config.emoji
    @o_config.emoji
  end

  def emojis_off
    @emojis = false
    @x_config.standard
    @o_config.standard
  end
end
