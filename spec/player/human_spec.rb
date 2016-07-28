require "spec_helper"

describe Player::Human do
  let(:player) { Player::Human.new(name: "Tester") }
  let(:game) { Game.new }

  before do
    allow(STDIN).to receive(:getch).and_return("1")
    allow(player).to receive(:print)
  end

  describe "#get_code" do
    it "captures an array with the given length" do
      expect(player.get_code(length: 4).length).to eq 4
    end

    it "captures an array of valid colors" do
      player.get_code(length: 4).each do |color|
        expect(Game::Piece::COLORS).to include color
      end
    end
  end

  describe "#get_guess_for" do
    it "captures an array with the length of the game secret" do
      expect(player.get_guess_for(game).length).to eq 4
    end
  end
end
