require "console/messages"
require "console/board_renderer"

class Console
  def initialize(options)
    @input = options[:input]
    @output = options[:output]
  end

  def greet_user
    print(messages.greet_user)
  end

  def show_options
    messages.options.each { |option| print(option) }
  end

  def show_instructions(player)
    print(messages.instructions(player))
  end

  def show_board(board)
    board_string = board_renderer.render(board)
    print(board_string)
  end

  def show_move_summary(move, player, oponent)
    print(messages.player_move(move, player))
    print(messages.player_turn(oponent))
  end

  def show_win(player)
    print(messages.player_win(player))
  end

  def show_draw
    print(messages.draw)
  end

  def get_move
    input.gets.chomp.to_r
  end

  def clear
    print(`clear`)
  end

  private
  attr_reader :board_renderer
  attr_reader :messages
  attr_reader :output
  attr_reader :input

  def print(message)
    output.puts(message)
  end

  def board_renderer        
    BoardRenderer.new
  end

  def messages
    Messages.new
  end
end
