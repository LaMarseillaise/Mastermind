require "spec_helper"

describe Game::Piece do
  let(:blue_piece) { Game::Piece.new(color: :blue) }
  let(:red_piece) { Game::Piece.new(color: :red) }

  describe "COLORS" do
    subject { Game::Piece::COLORS }

    it { is_expected.to include(:red) }
    it { is_expected.to include(:green) }
    it { is_expected.to include(:blue) }
    it { is_expected.to include(:yellow) }
    it { is_expected.to include(:white) }
    it { is_expected.to include(:black) }
  end

  describe "#initialize" do
    it "is valid with defaults" do
      expect{Game::Piece.new}.not_to raise_error
    end

    it "raises an error with an invalid color" do
      expect{Game::Piece.new(color: :orange)}.to raise_error(ArgumentError)
    end
  end

  describe "#==" do
    it "returns true with pieces of the same color" do
      expect(Game::Piece.new(color: :red) == red_piece).to be true
    end

    it "returns false with pieces of different colors" do
      expect(blue_piece == red_piece).to be false
    end
  end
end
