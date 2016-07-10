require "spec_helper"

describe Mastermind::Code do
  let(:red) { Mastermind::Piece.new(color: :red) }
  let(:blue) { Mastermind::Piece.new(color: :blue) }
  let(:green) { Mastermind::Piece.new(color: :green) }

  let(:code_blue) { Mastermind::Code.new(sequence: [blue, blue, blue, blue]) }
  let(:code_red)  { Mastermind::Code.new(sequence: [red, red, red, red]) }
  let(:other_red) { Mastermind::Code.new(sequence: [red, red, red, red]) }
  let(:red2_blue1){ Mastermind::Code.new(sequence: [red, red, blue, green]) }
  let(:green2_red2) { Mastermind::Code.new(sequence: [green, green, red, red]) }

  describe ".random" do
    it "generates a random sequence of pieces" do
      expect(Mastermind::Code.random).to be_a(Array)
      expect(Mastermind::Code.random).to all(be_a(Mastermind::Piece))
    end
  end

  describe ".from" do
    it "generates a code from the given colors" do
      expect(Mastermind::Code.from([:green, :green, :red, :red])).to eq(green2_red2)
    end
  end

  describe "#color_counts" do
    it "stores the number of red pieces" do
      expect(code_red.color_counts[:red]).to eq 4
      expect(red2_blue1.color_counts[:red]).to eq 2
    end

    it "does not store colors that are not present" do
      expect(code_blue.color_counts[:red]).to be nil
    end
  end

  describe "#exact_matches_with" do
    it "returns 1 when one piece matches exactly" do
      expect(red2_blue1.exact_matches_with(code_blue)).to eq 1
      expect(code_blue.exact_matches_with(red2_blue1)).to eq 1
    end

    it "returns 2 when two pieces match exactly" do
      expect(red2_blue1.exact_matches_with(code_red)).to eq 2
      expect(code_red.exact_matches_with(red2_blue1)).to eq 2
    end
  end

  describe "#color_matches_with" do
    it "returns 3 when there are three color matches" do
      expect(green2_red2.color_matches_with(red2_blue1)).to eq 3
      expect(red2_blue1.color_matches_with(green2_red2)).to eq 3
    end

    it "returns 4 when there are four color matches" do
      expect(code_red.color_matches_with(other_red)).to eq 4
    end
  end

  describe "#partial_matches_with" do
    it "does not double count exact matches" do
      expect(
        red2_blue1.partial_matches_with(code_red)
      ).not_to eq(
        red2_blue1.color_matches_with(code_red)
      )
    end
  end

  describe "#==" do
    it "returns true when the codes are the same" do
      expect(code_red == other_red).to be true
    end

    it "returns false when the codes are not the same" do
      expect(code_red == code_blue).to be false
    end

    it "returns false when given something that is not a code" do
      expect(code_red == 1).to be false
    end
  end
end
