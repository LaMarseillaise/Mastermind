module Mastermind
  class Human < Player
    def get_code(length: 4, attempt: nil)
      sequence = []

      length.times do
        turn = Turn.new(guess: Code.new(sequence: sequence), number: attempt)
        print "\r" + View.attempt_line(turn, width: length) if attempt
        color = Piece::COLORS[Human.get_choice(choices: ("1".."6")).to_i - 1]
        sequence << Piece.new(color: color)
      end

      Code.new(sequence: sequence)
    end

    def get_guess_for(game)
      length = game.secret_length
      get_code(length: length, attempt: game.attempts + 1)
    end

    def self.get_choice(choices:)
      begin
        choice = STDIN.getch
        exit if choice.start_with?('q') && !puts
      end until choices.include? choice

      choice
    end

    def self.get_input
      input = gets.chomp
      exit if input.downcase.start_with?('q')
      input
    end
  end
end
