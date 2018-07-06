require "core/players/player_symbol"

describe PlayerSymbol do
  it "indicates the player symbol" do
    player = PlayerSymbol.new(:X)
    expect(player.symbol).to eq(:X)
  end

  it "indicates the oponents symbol" do
    playerSymbol1 = PlayerSymbol.new(:O)
    expect(playerSymbol1.oponent).to eq(:X)

    playerSymbol2 = PlayerSymbol.new(:X)
    expect(playerSymbol2.oponent).to eq(:O)
  end
end
