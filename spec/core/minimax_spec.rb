require "core/players/minimax"
require "core/players/players"
require "core/players/player"
require "core/board"

describe Minimax do
  let(:minimax) { Minimax.new }
  let(:games) {[
    {:sequence => [1, 4, 2],       :blocking_move => 3},
    {:sequence => [1, 5, 7],       :blocking_move => 4},
    {:sequence => [1, 2, 3, 5, 4], :blocking_move => 7},
    {:sequence => [1, 5, 3],       :blocking_move => 2}
  ]}

  it "returns a correct blocking move to an oponent" do
    games.each do |game|
      board = sequence_board(game[:sequence])
      move = minimax.run(board)

      expect(move).to eq(game[:blocking_move])
    end
  end

  def sequence_board(sequence)
    board = Board.new
    players = Players.new(
      Player.new(:X),
      Player.new(:O)
    )

    sequence.each do |move|
      board = board.make_move(move, players.current_player_symbol)
      players.switch
    end

    board
  end
end
