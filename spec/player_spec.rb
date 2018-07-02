require "player"

RSpec.describe Player do
  it "returns the correct player symbol" do
    player_x = Player.new("X")
    expect(player_x.player_symbol).to eq("X")
  end
end
