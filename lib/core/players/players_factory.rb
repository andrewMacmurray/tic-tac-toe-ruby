require "core/players/human_player"
require "core/players/computer_player"
require "core/players/players"

class PlayersFactory
  def initialize(ui)
    @ui = ui
  end

  def create(option)
    return human_v_human       if option == 1
    return human_v_computer    if option == 2
    return computer_v_computer if option == 3
  end

  private
  def human_v_human
    Players.new(
      HumanPlayer.new(:X, @ui),
      HumanPlayer.new(:O, @ui)
    )
  end

  def human_v_computer
    Players.new(
      HumanPlayer.new(:X, @ui),
      ComputerPlayer.new(:O)
    )
  end

  def computer_v_computer
    Players.new(
      ComputerPlayer.new(:X),
      ComputerPlayer.new(:O)
    )
  end
end
