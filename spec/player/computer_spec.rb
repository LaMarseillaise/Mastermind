require "spec_helper"

describe Player::Computer do
  let(:computer) { Player::Computer.new(name: "Computer") }
  let(:game) { Game.new }

  describe "#get_code" do
    it "returns a code" do
      expect(computer.get_code(length: 1)).to be_a Game::Code
    end

    it "returns a code with the given length" do
      expect(computer.get_code(length: 4).length).to eq 4
      expect(computer.get_code(length: 3).length).to eq 3
    end
  end

  describe "#get_guess_for" do
    it "captures an array with the length of the game secret" do
      expect(computer.get_guess_for(game).length).to eq 4
    end
  end
end
