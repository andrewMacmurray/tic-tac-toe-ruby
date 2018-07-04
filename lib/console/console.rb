class Console
  def initialize(options)
    @output   = options[:output]
    @input    = options[:input]
    @board_ui = options[:board_ui]
    @messages = options[:messages]
  end

  def greet_user
    print(messages.greet_user)
  end

  def show_options
    messages.options.each { |option| print(option) }
  end

  def print_board(board)
    board_string = board_ui.render(board)
    print(board_string)
  end

  def show_move_summary(move, player_symbol)
    print(messages.player_move(move, player_symbol.symbol))
    print(messages.player_turn(player_symbol.oponent))
  end

  def get_move
    @input.gets.chomp
  end

  private
  def print(message)
    @output.puts(message)
  end

  def board_ui
    @board_ui
  end

  def messages
    @messages
  end
end
