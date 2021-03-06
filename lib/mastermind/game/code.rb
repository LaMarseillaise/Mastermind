module Mastermind
  class Game
    class Code
      attr_reader :sequence

      def self.random(number_of_pieces = 4)
        sequence = Array.new(number_of_pieces) { Piece.new }
        new(sequence: sequence)
      end

      def self.from(colors)
        new(sequence: colors.map { |color| Piece.new(color: color) })
      end

      def initialize(sequence:)
        raise ArgumentError unless sequence.all? { |piece| piece.is_a? Piece }
        @sequence = sequence
      end

      def length
        @sequence.length
      end

      def color_counts
        sequence.each_with_object({}) do |piece, counts|
          counts[piece.color] ||= 0
          counts[piece.color] += 1
        end
      end

      def exact_matches_with(code)
        raise ArgumentError unless code.is_a? Code
        sum = 0
        sequence.each_with_index do |piece, idx|
          sum += 1 if piece == code.sequence[idx]
        end
        sum
      end

      def color_matches_with(code)
        raise ArgumentError unless code.is_a? Code
        other_colors = code.color_counts
        sum = 0
        color_counts.each do |color, quantity|
          sum += [quantity, other_colors[color] || 0].min
        end
        sum
      end

      def partial_matches_with(code)
        raise ArgumentError unless code.is_a? Code
        color_matches_with(code) - exact_matches_with(code)
      end

      def ==(code)
        code.is_a?(Code) &&
        length == code.length &&
        exact_matches_with(code) == length
      end
    end
  end
end
