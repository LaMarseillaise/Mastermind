module Mastermind
  class Game
    class Piece
      COLORS = [:red, :green, :blue, :yellow, :white, :black]

      attr_reader :color

      def initialize(color: COLORS.sample)
        raise ArgumentError.new("Invalid color: #{color}.") unless COLORS.include?(color)
        @color = color
      end

      def ==(piece)
        piece.is_a?(Piece) && color == piece.color
      end
    end
  end
end
