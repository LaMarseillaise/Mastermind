require "spec_helper"

describe Player::Computer do
  let(:computer) { Player::Computer.new(name: "Computer") }
  let(:game) { Game.new }

  describe "#get_code" do
    it "captures an array with the given length" do
      expect(computer.get_code(length: 4).length).to eq 4
    end

    it "captures an array of valid colors" do
      computer.get_code(length: 4).each do |color|
        expect(Game::Piece::COLORS).to include color
      end
    end
  end

  describe "#get_guess_for" do
    it "captures an array with the length of the game secret" do
      expect(computer.get_guess_for(game).length).to eq 4
    end
  end
end
