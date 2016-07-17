module Mastermind
  module Console
    def self.run
      controller = Controller.new
      controller.setup
      loop { controller.start_game }
    end
  end
end
