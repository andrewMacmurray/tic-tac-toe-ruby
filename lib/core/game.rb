class Game
  def initialize(options)
    @board = options[:board]
    @players_factory = options[:players_factory]
    @ui = options[:ui]
  end

  def play
    ui.greet_user
    game_choice!
    play_round!
  end

  private
  attr_reader :players
  attr_reader :ui
  attr_accessor :board

  def game_choice!
    @players = ui.get_players(@players_factory)
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

  def make_move!(move)
    @board = board.make_move(move, players.current_player_symbol)
    @players.switch
  end
end
