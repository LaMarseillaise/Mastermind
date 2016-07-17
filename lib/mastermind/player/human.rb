module Mastermind
  class Player
    class Human < Player
      def get_code(length: 4, attempt: nil)
        sequence = []

        length.times do
          turn = Game::Turn.new(guess: Game::Code.new(sequence: sequence), number: attempt)
          print "\r" + Console::View.attempt_line(turn, width: length) if attempt
          color = Game::Piece::COLORS[Human.get_choice(choices: ("1".."6")).to_i - 1]
          sequence << Game::Piece.new(color: color)
        end

        Game::Code.new(sequence: sequence)
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
end
