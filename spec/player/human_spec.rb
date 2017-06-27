require "spec_helper"

describe Player::Human do
  let(:player) { Player::Human.new(name: "Tester") }
  let(:game) { Game.new }

  before do
    allow(STDIN).to receive(:getch).and_return("1")
    allow(player).to receive(:print)
  end

  describe "#get_code" do
    it "returns a code" do
      expect(player.get_code(length: 1)).to be_a Game::Code
    end

    it "returns a code with the given length" do
      expect(player.get_code(length: 4).length).to eq 4
      expect(player.get_code(length: 3).length).to eq 3
    end
  end

  describe "#get_guess_for" do
    it "captures an array with the length of the game secret" do
      expect(player.get_guess_for(game).length).to eq 4
    end
  end
end
