class Messages
  def greet_user
    "Welcome to Tic Tac Toe!"
  end

  def options
    [
      "Which type of game would you like to play",
      "1. Human vs Human",
      "2. Human vs Computer",
      "3. Computer vs Computer",
      "Please enter 1, 2 or 3"
    ]
  end

  def prompt
    "> "
  end

  def use_emojis
    "Would you like to use emojis as tiles?"
  end

  def yes_no
    "Enter Y or N"
  end

  def unrecognised
    "Sorry I didn't recognise that "
  end

  def instructions(player)
    "Ok player #{player} enter a number from 1-9"
  end

  def player_move(move, player)
    "Player #{player} took tile #{move}"
  end

  def already_taken(move_index)
    "Tile #{move_index} has already been taken!"
  end

  def player_turn(player)
    "Your turn player #{player}"
  end

  def player_win(player)
    "Player #{player} won!"
  end

  def draw
    "It's a draw!"
  end

  def play_again
    "Do you want to play another game?"
  end

  def goodbye
    "Ok bye! 👋"
  end
end
