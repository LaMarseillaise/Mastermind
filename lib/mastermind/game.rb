module Mastermind
  class Game
    attr_reader :turns, :codemaker, :codebreaker, :max_attempts

    def initialize(secret: nil, codemaker: nil, codebreaker: nil)
      @secret = (secret && Code.from(secret)) || Code.random
      @turns = []
      @codemaker = codemaker || Player.new(name: "AbstractCodemaker")
      @codebreaker = codebreaker || Player.new(name: "AbstractCodebreaker")
      @max_attempts = 12
    end

    def attempts
      turns.length
    end

    def secret_length
      @secret.length
    end

    def guess(guess_sequence)
      code = Code.from(guess_sequence)
      @turns << Turn.new(
        guess: code, number: attempts + 1,
        exact: @secret.exact_matches_with(code),
        partial: @secret.partial_matches_with(code)
      )
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
      turns.first(max_attempts).any? { |turn| turn.guess == @secret }
    end
  end
end
