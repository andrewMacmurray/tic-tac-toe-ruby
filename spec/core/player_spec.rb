require "core/players/player"

describe Player do
  it "indicates the player's symbol" do
    player = Player.new(:X)
    expect(player.symbol).to eq(:X)
  end

  it "indicates the oponent's symbol" do
    playerSymbol1 = Player.new(:O)
    expect(playerSymbol1.oponent).to eq(:X)

    playerSymbol2 = Player.new(:X)
    expect(playerSymbol2.oponent).to eq(:O)
  end
end
