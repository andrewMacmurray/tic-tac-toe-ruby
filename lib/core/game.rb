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
    while !board.terminus_reached? do
      eval_move!
    end    
    ui.game_summary(board)
  end

  def eval_move!
    move = request_move
    if board.valid_move?(move)
      make_move!(move)
    end
  end

  def request_move
    player  = players.current_player_symbol
    oponent = players.current_oponent_symbol
    move = players.request_move(board)
    ui.move_summary(move, board, player, oponent)
    move
  end

  def make_move!(move)
    @board = board.make_move(move, players.current_player_symbol)
    @players.switch
  end
end
