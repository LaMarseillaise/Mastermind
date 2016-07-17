module Mastermind
  class Player
    class Computer < Player
      def get_guess_for(game)
        @knuth = Knuth.new(game) unless @knuth && @knuth.game == game
        Game::Code.from(@knuth.prepare_guess)
      end

      def get_code(length:)
        Game::Code.random(length)
      end
    end
  end
end
