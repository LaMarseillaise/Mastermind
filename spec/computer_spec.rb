require "spec_helper"

describe Mastermind::Computer do
  let(:computer) { Mastermind::Computer.new(name: "Computer") }
  let(:game) { Mastermind::Game.new(codebreaker: computer) }

  describe "#get_code" do
    it "captures a code" do
      expect(computer.get_code(length: 4)).to be_a Mastermind::Code
    end
  end

  describe "#get_guess_for" do
    it "captures a code" do
      expect(computer.get_guess_for(game)).to be_a Mastermind::Code
    end
  end
end
