module Mastermind
  class Knuth
    attr_reader :game

    def initialize(game)
      @game = game
      # 1. Create the set S of 1296 possible codes
      @possible_guesses = Game::Piece::COLORS.repeated_permutation(game.secret_length).to_a
      @set = Game::Piece::COLORS.repeated_permutation(game.secret_length).to_a
      @game.turns.each { |turn| prune(turn) }
    end

    def prepare_guess
      return first_guess if @game.attempts == 0
      prune(@game.turns.last)
      return @set.first if @set.length == 1
      exploratory_guess
    end

    # 2. Make initial guess of 1122
    def first_guess
      first_color = Game::Piece::COLORS.sample
      second_color = Game::Piece::COLORS.select { |color| color != first_color }.sample
      Array.new(@game.secret_length) do |position|
        position < @game.secret_length / 2 ? first_color : second_color
      end
    end

    # 5. Choose from the set of guesses with the maximum score, preferring members of S
    def exploratory_guess
      max_scoring = maximum_scoring_guesses
      (max_scoring & @set).sample || max_scoring.sample
    end

    private

    # 3. Remove from S any code that would not give the same response if the guess were the code.
    def prune(turn)
      @set.select! do |combination|
        code = Game::Code.from(combination)
        !(turn.guess == code) &&
        turn.exact   == code.exact_matches_with(turn.guess) &&
        turn.partial == code.partial_matches_with(turn.guess)
      end

      @possible_guesses.delete(turn.guess)
    end

    # 4. For each possible guess, find the minimum highest match count
    def minimum_match_count
      lowest = @set.length
      @possible_guesses.each do |possible|
        count = highest_match_count(Game::Code.from(possible))
        lowest = count if count < lowest
      end
      lowest
    end

    def highest_match_count(guess)
      highest = 0
      # for a given number of matches
      (0..@game.secret_length).each do |matches|
        # count how many possibilities in S would be retained
        count = @set.count do |combination|
          Game::Code.from(combination).color_matches_with(guess) == matches
        end
        # track the highest of these
        highest = count if count > highest
      end
      highest
    end

    # Find the possible guesses for which the highest match count is the minimum match count.
    def maximum_scoring_guesses
      min_matches = minimum_match_count
      @possible_guesses.select do |possible|
        highest_match_count(Game::Code.from(possible)) == min_matches
      end
    end
  end
end
