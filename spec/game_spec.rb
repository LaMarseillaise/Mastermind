require "spec_helper"

describe Mastermind::Game do
  let(:red) { Mastermind::Piece.new(color: :red) }
  let(:blue) { Mastermind::Piece.new(color: :blue) }

  let(:secret) { Mastermind::Code.new(sequence: [red, red, red, red]) }
  let(:guess) { Mastermind::Code.new(sequence: [blue, blue, blue, blue]) }

  let(:game) { Mastermind::Game.new(secret: secret) }

  describe "#guess" do
    it "increments the number of attempts" do
      expect{game.guess(guess)}.to change(game, :attempts).by 1
    end

    it "adds the guess to the list of guesses" do
      game.guess(guess)
      expect(game.guesses).to include(guess)
    end
  end

  describe "#over?" do
    it "defaults false" do
      expect(game.over?).to be false
    end

    it "is false for the first 11 attempts" do
      11.times do
        game.guess(guess)
        expect(game.over?).to be false
      end
    end

    it "is true when there have been twelve attempts" do
      12.times { game.guess(guess) }
      expect(game.over?).to be true
    end

    it "is true when one of the guesses is correct" do
      game.guess(guess)
      game.guess(secret)
      expect(game.over?).to be true
    end
  end
end
