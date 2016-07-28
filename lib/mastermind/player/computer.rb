module Mastermind
  class Player
    class Computer < Player
      def get_guess_for(game)
        @knuth = Knuth.new(game) unless @knuth && @knuth.game == game
        @knuth.prepare_guess
      end

      def get_code(length:)
        Array.new(length) { Game::Piece::COLORS.sample }
      end
    end
  end
end
