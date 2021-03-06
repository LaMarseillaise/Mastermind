module Mastermind
  module Console
    class Controller
      def setup
        puts View.introduction
        print "How many human players will there be? "
        number_of_players = Player::Human.get_input.to_i

        @player1 = get_player(1) if number_of_players > 0
        @player1 ||= Player::Computer.new(name: "Computer (1)")
        @player2 = get_player(2) if number_of_players > 1
        @player2 ||= Player::Computer.new(name: "Computer")
      end

      def start_game
        codebreaker = get_codebreaker
        codemaker = (codebreaker == @player1) ? @player2 : @player1

        play Game.new(
          secret: get_secret_from(codemaker),
          codemaker: codemaker,
          codebreaker: codebreaker
        )

        puts "\n\n"
      end

      def play(game)
        width = game.secret_length
        puts "#{game.codebreaker.name} must guess the code."
        puts View.grading_scheme
        puts View.top_border(width: width)
        make_guess(game) until game.over?
        puts View.bottom_border(width: width)
        puts "#{game.winner.name} wins! (#{game.attempts} guesses)"
      end


      private

      def get_player(number)
        print "What is Player #{number}'s name? "
        Player::Human.new(name: gets.chomp)
      end

      def get_codebreaker
        puts "Who will be the code breaker?\n1. #{@player1.name}\n2. #{@player2.name}"
        (selection = Player::Human.get_input.to_i) until (1..2) === selection
        [@player1, @player2][selection - 1]
      end

      def get_secret_from(codemaker)
        puts View.color_codes
        puts "#{codemaker.name}: What will the secret code be?" if codemaker.is_a? Player::Human
        codemaker.get_code(length: 4)
      end

      def make_guess(game)
        guess = game.codebreaker.get_guess_for(game)
        game.guess(guess)
        puts "\r" + View.attempt_line(game.turns.last, width: game.secret_length)
      end
    end
  end
end
