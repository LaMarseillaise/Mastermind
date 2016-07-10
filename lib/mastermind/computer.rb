module Mastermind
  class Computer < Player
    def get_guess_for(game)
      return initial_guess if game.attempts < 1
      Code.new(sequence: Code.random(game.secret_length))
    end

    def get_code(length:)
      Code.new(sequence: Code.random(length))
    end


    private

    def initial_guess
      color1 = Piece::COLORS.sample
      begin
        color2 = Piece::COLORS.sample
      end until color1 != color2

      Code.new(sequence: [
        Piece.new(color: color1),
        Piece.new(color: color1),
        Piece.new(color: color2),
        Piece.new(color: color2)
      ])
    end
  end
end
