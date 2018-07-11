require "console/tile_renderer"

class BoardRenderer
  def initialize()
    @tile_renderer = TileRenderer.new
  end

  def render(board)
    lines(tile_strings(board)).join("\n")
  end

  def emoji_tiles
    @tile_renderer.toggle_emojis(true)
  end

  def standard_tiles
    @tile_renderer.toggle_emojis(false)
  end

  private
  def tile_strings(board)
    win_moves = board.winning_moves
    board.tiles.map do |tile|
      @tile_renderer.render(tile, win_moves)
    end
  end

  def line_to_s(line)
    line.join("|")
  end

  def lines(tile_strings)
    tile_lines = tile_strings.each_slice(3).to_a
    tile_lines.map { |line| line_to_s(line) } 
  end
end
