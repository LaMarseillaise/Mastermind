require "spec_helper"

describe Mastermind::Controller do
  let(:secret) { Mastermind::Code.from([:red, :red, :red]) }
  let(:guess) { Mastermind::Code.from([:blue, :blue, :blue]) }

  let(:player) { Mastermind::Player.new(name: "Somebody") }
  let(:game) { Mastermind::Game.new(secret: secret, codebreaker: player) }

  let(:controller) { Mastermind::Controller.new }

  before do
    allow(controller).to receive(:puts)
    allow(controller).to receive(:print)
    allow(player).to receive(:get_guess_for).and_return(guess, secret)
  end

  describe "#play" do
    it "completes a game" do
      controller.play(game)
      expect(game.winner).to be player
    end
  end
end
