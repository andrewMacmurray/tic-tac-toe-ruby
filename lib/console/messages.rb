class Messages
  def greet_user() "Welcome to Tic Tac Toe!" end

  def options
    [
      "Which type of game would you like to play",
      "1. Human vs Human",
      "2. Human vs Computer",
      "3. Computer vs Computer",
      "Please enter 1, 2 or 3"
    ]
  end

  def player_move(move, player)
    "Player #{player} took tile #{move}"
  end

  def player_turn(player)
    "Your turn player #{player}"
  end
end
