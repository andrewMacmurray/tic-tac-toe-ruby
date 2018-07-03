require "board"
require "player_symbol"

describe Board do
  it "lists the available moves" do
    board = Board.new(3)
    expected_moves = (1..9).to_a

    expect(board.available_moves).to eq(expected_moves)
  end

  it "marks the board with a move for a given player" do
    board = Board.new(3)
    player = PlayerSymbol.new(:X)
    board.make_move(1, player)

    expected_moves = (2..9).to_a

    expect(board.available_moves).to eq(expected_moves)
  end

  it "indicates if the board is full" do
    board = Board.new(3)
    player = PlayerSymbol.new(:X)

    expect(board.is_full?).to be(false)

    (1..9).each do |i|
      board.make_move(i, player)
    end

    expect(board.is_full?).to be(true)
  end

  it "indicates if a player has a winning combination" do
    winning_combinations =  [
      [1,2,3], [4,5,6], [7,8,9],
      [1,4,7], [2,5,8], [3,5,9],
      [1,5,9], [3,5,7]
    ]

    winning_combinations.each do |combination|
      board = Board.new(3)
      player = PlayerSymbol.new(:X)
      combination.each { |number| board.make_move(number, player)  }

      expect(board.has_won?(player)).to be(true)
    end
  end
end
