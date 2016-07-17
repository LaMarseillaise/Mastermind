module Mastermind
  class Game
    class Turn
      attr_reader :guess, :exact, :partial, :number

      def initialize(guess:, number:, exact: 0, partial: 0)
        @guess = guess
        @exact = exact
        @partial = partial
        @number = number
      end
    end
  end
end
