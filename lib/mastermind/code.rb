module Mastermind
  class Code
    attr_reader :sequence

    def self.random(number_of_pieces = 4)
      Array.new(number_of_pieces) { Mastermind::Piece.new }
    end

    def initialize(sequence: Mastermind::Code.random)
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
      sum = 0
      sequence.each_with_index do |piece, idx|
        sum += 1 if piece == code.sequence[idx]
      end
      sum
    end

    def color_matches_with(code)
      other_colors = code.color_counts
      sum = 0
      color_counts.each do |color, quantity|
        sum += [quantity, other_colors[color] || 0].min
      end
      sum
    end

    def ==(code)
      code.is_a?(Mastermind::Code) &&
      length == code.length &&
      exact_matches_with(code) == length
    end
  end
end
