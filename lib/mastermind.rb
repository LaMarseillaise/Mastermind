require "mastermind/version"
require "mastermind/piece"
require "mastermind/code"
require "mastermind/game"
require "mastermind/player"
require "mastermind/computer"
require "mastermind/human"
require "mastermind/view"
require "mastermind/controller"
require "mastermind/knuth"

module Mastermind
  def self.run_in_console
    controller = Mastermind::Controller.new
    controller.setup
    loop { controller.start_game }
  end
end
