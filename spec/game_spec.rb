require "spec_helper"

describe Mastermind::Game do
  let(:secret) { Mastermind::Code.from([:red, :red, :red, :red]) }
  let(:guess) { Mastermind::Code.from([:blue, :blue, :blue, :blue]) }

  let(:game) { Mastermind::Game.new(secret: secret) }

  describe "#guess" do
    it "increments the number of attempts" do
      expect{game.guess(guess)}.to change(game, :attempts).by 1
    end

    it "adds the guess to the history of guesses" do
      game.guess(guess)
      expect(game.turns.map(&:guess)).to include(guess)
    end
  end

  describe "#over?" do
    it "is not over at the start" do
      expect(game.over?).to be false
    end

    it "is not over before the maximum number of attempts is reached" do
      (game.max_attempts - 1).times do
        game.guess(guess)
        expect(game.over?).to be false
      end
    end

    it "is over when the maximum number of attempts is reached" do
      game.max_attempts.times { game.guess(guess) }
      expect(game.over?).to be true
    end

    it "is over when one of the guesses is correct" do
      game.guess(guess)
      game.guess(secret)
      expect(game.over?).to be true
    end
  end

  describe "#winner" do
    it "is no one when the game is not over" do
      expect(game.winner).to be nil
    end

    it "is the codebreaker when the code has been guessed" do
      game.guess(secret)
      expect(game.winner).to be game.codebreaker
    end

    it "is the codemaker when the code has not been guessed in 12 attempts" do
      game.max_attempts.times { game.guess(guess) }
      expect(game.winner).to be game.codemaker
    end

    it "is the codemaker if the code is guessed after too many attempts" do
      game.max_attempts.times { game.guess(guess) }
      game.guess(secret)
      expect(game.winner).to be game.codemaker
    end
  end
end
