module Mastermind
  class Game
    attr_reader :guesses, :codemaker, :codebreaker, :max_attempts

    def initialize(secret: Code.new, guesses: [], codemaker: nil, codebreaker: nil)
      raise ArgumentError unless secret.is_a? Code
      @secret = secret
      @guesses = guesses
      @codemaker = codemaker || Player.new(name: "AbstractCodemaker")
      @codebreaker = codebreaker || Player.new(name: "AbstractCodebreaker")
      @max_attempts = 12
    end

    def attempts
      guesses.length
    end

    def secret_length
      @secret.length
    end

    def guess(code)
      raise ArgumentError unless code.is_a? Code
      @guesses << code
    end

    def count_exact_matches(code)
      raise ArgumentError unless code.is_a? Code
      @secret.exact_matches_with(code)
    end

    def count_partial_matches(code)
      raise ArgumentError unless code.is_a? Code
      @secret.partial_matches_with(code)
    end

    def over?
      max_attempts_reached? || code_guessed?
    end

    def winner
      return codebreaker if code_guessed?
      return codemaker if max_attempts_reached?
    end


    private

    def max_attempts_reached?
      attempts >= max_attempts
    end

    def code_guessed?
      guesses.first(max_attempts).any? { |guess| guess == @secret }
    end
  end
end
