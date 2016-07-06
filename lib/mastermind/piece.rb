module Mastermind
  class Piece
    COLORS = [:red, :green, :blue, :yellow, :white, :black]

    attr_reader :color

    def initialize(color: COLORS.sample)
      raise ArgumentError.new("Invalid color.") unless COLORS.include?(color)
      @color = color
    end

    def ==(other_piece)
      other_piece.is_a?(Piece) && color == other_piece.color
    end
  end
end
