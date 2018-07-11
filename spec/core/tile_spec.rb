require "core/tile"

describe Tile do
  it "Returns the correct index and symbol" do
    tile = Tile.new(1, :X)
    expect(tile.number).to eq(1)
    expect(tile.player_symbol).to eq(:X)
  end

  it "Returns empty if no player symbol is given" do
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

  it "can apply a custom to_s to a tile" do
    custom_f = lambda do |tile|
      return "foo" if tile == :X
      return "bar" if tile == :O
      "baz #{tile}"
    end

    tile1 = Tile.new(3)
    tile2 = Tile.new(:X)
    tile3 = Tile.new(:O)

    expect(tile1.to_s_with(custom_f)).to eq("baz 3")
    expect(tile2.to_s_with(custom_f)).to eq("foo")
    expect(tile3.to_s_with(custom_f)).to eq("bar")
  end
end
