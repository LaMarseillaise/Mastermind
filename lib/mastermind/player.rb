module Mastermind
  class Player
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def get_code
      raise NotImplementedError.new("Abstract player cannot make code.")
    end

    def get_guess_for(game)
      raise NotImplementedError.new("Abstract player cannot guess code.")
    end
  end
end
