module Mastermind
  class Computer < Player
    def get_guess_for(game)
      Code.new(sequence: Code.random(game.secret_length))
    end

    def get_code(length:)
      Code.new(sequence: Code.random(length))
    end
  end
end
