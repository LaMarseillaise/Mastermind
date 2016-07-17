require "spec_helper"

describe Player::Computer do
  let(:computer) { Player::Computer.new(name: "Computer") }
  let(:game) { Game.new(codebreaker: computer) }

  describe "#get_code" do
    it "captures a code" do
      expect(computer.get_code(length: 4)).to be_a Game::Code
    end
  end

  describe "#get_guess_for" do
    it "captures a code" do
      expect(computer.get_guess_for(game)).to be_a Game::Code
    end
  end
end
