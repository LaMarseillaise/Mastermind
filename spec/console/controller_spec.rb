require "spec_helper"

describe Console::Controller do
  let(:secret) { Game::Code.from([:red, :red, :red]) }
  let(:guess) { Game::Code.from([:blue, :blue, :blue]) }

  let(:player) { Player.new(name: "Somebody") }
  let(:game) { Game.new(secret: secret, codebreaker: player) }

  let(:controller) { Console::Controller.new }

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
