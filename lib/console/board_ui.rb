class BoardUI
  def render(board)
    tile_strings = board.tiles.map { |tile| tile.to_s }
    lines(tile_strings).join("\n")
  end

  def line_to_s(line)
    line.join(" | ")
  end

  def lines(tile_strings)
    tile_lines = tile_strings.each_slice(3).to_a
    tile_lines.map { |line| line_to_s(line) } 
  end
end
