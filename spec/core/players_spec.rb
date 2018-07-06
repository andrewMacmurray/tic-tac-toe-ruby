require "core/players/players"
require "core/players/player_symbol"

describe Players do
  it "should get the current player smymbol" do
    players = make_players
    expect(players.current_player_symbol).to eq(:X)
  end

  it "switches the current player for the oponent" do
    players = make_players 
    players.switch
    expect(players.current_player_symbol).to eq(:O)
  end

  it "switches players back correctly" do
    players = make_players
    players.switch
    players.switch
    expect(players.current_player_symbol).to eq(:X)
  end

  def make_players
    Players.new(PlayerSymbol.new(:X), PlayerSymbol.new(:O))
  end
end
