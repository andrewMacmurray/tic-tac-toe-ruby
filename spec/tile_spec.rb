require "tile"

RSpec.describe Tile do
  it "Returns the correct index and symbol" do
    tile = Tile.new(1, :X)
    expect(tile.number).to eq(1)
    expect(tile.player_symbol).to eq(:X)
  end

  it "Returns nil if no player symbol is given" do
    tile = Tile.new(1)
    expect(tile.player_symbol).to eq(:empty)
  end

  it "Indicates if tile is empty" do
    tile = Tile.new(1)
    expect(tile.is_empty?).to be(true)

    tile = Tile.new(1, "X")
    expect(tile.is_empty?).to be(false)
  end

  it "Returns player symbol if player has taken tile" do
    tile = Tile.new(1, :O)
    expect(tile.to_s).to eq(:O)
  end

  it "Returns the index if no player has taken tile" do
    tile = Tile.new(3)
    expect(tile.to_s).to eq(3)
  end
end
