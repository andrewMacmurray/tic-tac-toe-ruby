class Game
  def initialize(options)
    @board = options[:board]
    @players_factory = options[:players_factory]
    @ui = options[:ui]
  end

  def play
    ui.greet_user
    run_single_game
    play_again?
  end

  private
  attr_reader :players, :ui
  attr_accessor :board

  def run_single_game
    game_settings!
    instructions
    play_round!
  end

  def game_settings!
    game_choice!
    emojis!
  end

  def game_choice!
    choice   = ui.game_choice
    @players = @players_factory.create(choice) 
  end

  def emojis!
    ui.use_emojis
  end

  def instructions
    ui.game_instructions(@players.current_player_symbol, board)
  end

  def play_round!
    while !board.terminus_reached? do
      evaluate_move!
    end    
    ui.game_summary(board)
  end

  def evaluate_move!
    move = request_move
    if board.valid_move?(move)
      make_move!(move)
    end
  end

  def request_move
    player   = players.current_player_symbol
    opponent = players.current_opponent_symbol
    move     = players.request_move(board)
    ui.move_summary(move, board, player, opponent)
    move
  end

  def play_again?
    return next_game if @ui.play_again?
    return @ui.goodbye
  end

  def next_game
    reset_board
    play
  end

  def reset_board
    @board = Board.new
  end

  def make_move!(move)
    @board = board.make_move(move, players.current_player_symbol)
    @players.switch
  end
end
