module Mastermind
  class Game
    attr_reader :guesses

    def initialize(secret: Code.new, guesses: [])
      @secret = secret
      @guesses = guesses
    end

    def attempts
      guesses.length
    end

    def guess(code)
      @guesses << code
    end

    def over?
      attempts == 12 || guesses.any? { |guess| guess == @secret }
    end
  end
end
