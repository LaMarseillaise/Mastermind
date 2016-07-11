module Mastermind
  class Knuth
    attr_reader :game

    def initialize(game)
      @game = game
      # 1. Create the set S of 1296 possible codes
      @possible_guesses = Piece::COLORS.repeated_permutation(game.secret_length).to_a
      @set = Piece::COLORS.repeated_permutation(game.secret_length).to_a
      @game.guesses.each { |guess| prune(guess) }
    end

    def prepare_guess
      return first_guess if @game.guesses.length == 0
      prune(@game.guesses.last)
      return @set.first if @set.length == 1
      exploratory_guess
    end


    private

    # 2. Make initial guess of 1122
    def first_guess
      combination = Array.new(@game.secret_length)
      combination.map!.with_index do |item, idx|
        idx % 2 == 0 ? Piece::COLORS.sample : combination[idx - 1]
      end
    end

    # 3. Remove from S any code that would not give the same response if the guess were the code.
    def prune(guess)
      @set.select! do |combination|
        retain?(
          code: Code.from(combination),
          guess: guess,
          exact: @game.count_exact_matches(guess),
          partial: @game.count_partial_matches(guess)
        )
      end

      @possible_guesses.delete(guess)
    end

    def retain?(guess:, code:, exact:, partial:)
      !(code == guess) &&
      code.exact_matches_with(guess) == exact &&
      code.partial_matches_with(guess) == partial
    end

    # 4. For each possible guess, find the minimum highest match count
    def minimum_match_count
      lowest = @set.length
      @possible_guesses.each do |possible|
        count = highest_match_count(Code.from(possible))
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
          Code.from(combination).color_matches_with(guess) == matches
        end
        # track the highest of these
        highest = count if count > highest
      end
      highest
    end

    def maximum_scoring_guesses(min_matchs)
      @possible_guesses.select do |guess|
        highest_match_count(Code.from(guess)) == min_matchs
      end
    end

    # 5. Choose from the set of guesses with the maximum score, preferring members of S
    def exploratory_guess
      max_scoring = maximum_scoring_guesses(minimum_match_count)
      (max_scoring & @set).sample || max_scoring.sample
    end
  end
end
