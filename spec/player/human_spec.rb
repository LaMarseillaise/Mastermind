require "spec_helper"

describe Player::Human do
  let(:player) { Player::Human.new(name: "Tester") }
  let(:game) { Game.new(codebreaker: player) }

  before do
    allow(STDIN).to receive(:getch).and_return("1")
    allow(player).to receive(:print)
  end

  describe "#get_code" do
    it "captures a code" do
      expect(player.get_code(length: 4)).to be_a Game::Code
    end
  end

  describe "#get_guess_for" do
    it "captures a code" do
      expect(player.get_guess_for(game)).to be_a Game::Code
    end
  end
end
