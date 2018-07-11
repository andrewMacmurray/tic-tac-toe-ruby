require "core/board"

describe Board do
  it "lists the available moves" do
    board = Board.new
    expected_moves = (1..9).to_a

    expect(board.available_moves).to eq(expected_moves)
  end

  it "marks the board with a move for a given player" do
    board = Board.new
    board = board.make_move(1, :X)

    expected_moves = (2..9).to_a

    expect(board.available_moves).to eq(expected_moves)
  end

  it "creates a fresh copy of the board when making a move" do
    board = Board.new
    board2 = board.make_move(1, :X)

    expect(board.available_moves.length).to eq(9)
    expect(board2.available_moves.length).to eq(8)
  end

  it "indicates if the board is full" do
    board = Board.new

    expect(board.full?).to be(false)

    (1..9).each do |i|
      board = board.make_move(i, :X)
    end

    expect(board.full?).to be(true)
  end

  it "indicates if given move is valid" do
    board = Board.new

    expect(board.valid_move?(5)).to be(true)

    next_board = board.make_move(5, :X)

    expect(next_board.valid_move?(5)).to be(false)
  end

  it "indicates if a player has a winning combination" do
    winning_combinations =  [
      [1,2,3], [4,5,6], [7,8,9],
      [1,4,7], [2,5,8], [3,6,9],
      [1,5,9], [3,5,7]
    ]

    winning_combinations.each do |combination|
      board = Board.new
      combination.each { |number| board = board.make_move(number, :X)  }

      expect(board.has_won?(:X)).to be(true)
    end
  end

  it "retrievies the winning moves" do
    board = Board.new
      .make_move(1, :X)
      .make_move(2, :X)
      .make_move(3, :X)

    expect(board.winning_moves).to eq([1, 2, 3])
  end

  it "gives an empty list if no winning moves" do
    board = Board.new

    expect(board.winning_moves).to eq([])
  end
end
