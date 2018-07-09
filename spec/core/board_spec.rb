require "core/board"

describe Board do
  it "lists the available moves" do
    board = Board.new
    expected_moves = (1..9).to_a

    expect(board.available_moves).to eq(expected_moves)
  end

  it "marks the board with a move for a given player" do
    board = Board.new
    board.make_move(1, :X)

    expected_moves = (2..9).to_a

    expect(board.available_moves).to eq(expected_moves)
  end

  it "indicates if the board is full" do
    board = Board.new

    expect(board.is_full?).to be(false)

    (1..9).each do |i|
      board.make_move(i, :X)
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
      board = Board.new
      combination.each { |number| board.make_move(number, :X)  }

      expect(board.has_won?(:X)).to be(true)
    end
  end
end
