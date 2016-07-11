module Mastermind
  class Computer < Player
    def get_guess_for(game)
      @knuth = Knuth.new(game) unless @knuth && @knuth.game == game
      Code.from(@knuth.prepare_guess)
    end

    def get_code(length:)
      Code.new(sequence: Code.random(length))
    end
  end
end
