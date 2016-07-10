require "colorize"

module Mastermind
  class View
    TL_CORNER = "\u250F"
    TM_INTER = "\u2533"
    TR_CORNER = "\u2513"
    BL_CORNER = "\u2517"
    BM_INTER = "\u253B"
    BR_CORNER = "\u251B"
    HORIZONTAL = "\u2501"
    SIDE = "\u2503"
    BLANK = " "
    PIECE = "\u25CF"
    EXACT = "\u25CF".red
    PARTIAL = "\u25CF".white

    def self.introduction
      "MASTERMIND\n" +
      "" +
      "\n"
    end

    def self.grading_scheme
      "#{EXACT}: Matched color and position  #{PARTIAL}: Matched color"
    end

    def self.color_codes
      Piece::COLORS.map.with_index do |color, idx|
        "#{idx + 1}: #{piece_icon(color)}"
      end.join("  ") + "  q: exit"
    end

    def self.top_border(width: 4)
      "    " + TL_CORNER + HORIZONTAL * width + TM_INTER + HORIZONTAL * width + TR_CORNER
    end

    def self.bottom_border(width: 4)
      "    " + BL_CORNER + HORIZONTAL * width + BM_INTER + HORIZONTAL * width + BR_CORNER
    end

    def self.attempt_line(sequence, width: 4, exact: 0, partial: 0, attempt: 0)
      "#{attempt}:".ljust(4) +
      SIDE + guess_bar(sequence) + BLANK * (width - sequence.length) + SIDE +
      feedback_line(exact: exact, partial: partial, width: width) + SIDE
    end

    def self.feedback_line(exact: 0, partial: 0, width: 4)
      EXACT * exact + PARTIAL * partial + BLANK * (width - exact - partial)
    end

    def self.piece_icon(color)
      PIECE.colorize(color)
    end

    def self.guess_bar(sequence)
      sequence.map { |piece| piece_icon(piece.color) }.join("")
    end
  end
end
