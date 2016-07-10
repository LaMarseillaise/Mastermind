require "spec_helper"

describe Mastermind::Player do
  let(:player) { Mastermind::Player.new(name: "Player") }
  let(:game) { Mastermind::Game.new(codebreaker: player) }

  describe "#initialize" do
    it "must have a name" do
      expect{player}.not_to raise_error
      expect{Mastermind::Player.new}.to raise_error ArgumentError
    end
  end

  describe "#get_code" do
    it "raises an error" do
      expect{player.get_code}.to raise_error NotImplementedError
    end
  end

  describe "#get_guess_for" do
    it "raises an error" do
      expect{player.get_guess_for(game)}.to raise_error NotImplementedError
    end
  end
end
