require "spec_helper"

describe Knuth do
  let(:secret) { Game::Code.from([:red, :red]) }
  let(:guess) { Game::Code.from([:blue, :blue]) }
  let(:game) { Game.new(secret: secret) }

  let(:knuth) { Knuth.new(game) }

  describe "#prepare_guess" do
    it "makes a first guess if there are no attempts" do
      expect(knuth).to receive(:first_guess)
      knuth.prepare_guess
    end

    it "makes an exploratory guess after the first guess" do
      game.guess(guess)
      expect(knuth).to receive(:exploratory_guess)
      knuth.prepare_guess
    end

    it "prunes the set of possible guesses after the first guess" do
      game.guess(guess)
      expect(knuth).to receive(:prune)
      knuth.prepare_guess
    end
  end

  describe "#first_guess" do
    it "makes a guess that is the same length as the secret" do
      expect(knuth.first_guess.length).to eq game.secret_length
    end

    it "guesses two different colors" do
      first_guess = knuth.first_guess
      10.times { expect(first_guess.sequence.first).not_to eq(first_guess.sequence.last) }
    end
  end

  describe "#exploratory_guess" do
    it "makes a guess that is the same length as the secret" do
      expect(knuth.exploratory_guess.length).to eq game.secret_length
    end

    it "makes a guess that gives the maximum score" do
      expect(knuth).to receive(:maximum_scoring_guesses).and_return([guess])
      knuth.exploratory_guess
    end
  end
end
