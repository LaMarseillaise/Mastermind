module Mastermind
  class Turn
    attr_reader :guess, :exact, :partial, :number

    def initialize(guess:, exact:, partial:, number:)
      @guess = guess
      @exact = exact
      @partial = partial
      @number = number
    end
  end
end
