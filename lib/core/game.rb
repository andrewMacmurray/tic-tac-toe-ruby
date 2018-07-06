class Game
  def initialize(options)
    @board = options[:board]
    @players = options[:players]
    @ui = options[:ui]
  end

  def play
    ui.greet_user
    play_round
  end

  private
  attr_reader :players
  attr_reader :ui
  attr_accessor :board

  def play_round
    while !board.is_terminal? do
      next_move = ui.get_move
      play_move(next_move)
    end    
    game_summary
  end

  def play_move(move)
    ui.clear
    make_move(move)
    move_summary(move)
    players.switch
  end

  def make_move(move)
    board.make_move(move, players.current_player_symbol)
    ui.show_board(board)
  end

  def move_summary(move)
    player  = players.current_player_symbol
    oponent = players.current_oponent_symbol
    ui.show_move_summary(move, player, oponent)
  end

  def game_summary
    ui.show_draw    if board.is_full?
    ui.show_win(:X) if board.has_won?(:X)
    ui.show_win(:O) if board.has_won?(:O)
  end
end
