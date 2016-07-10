require "spec_helper"

describe Mastermind::Player do
  let(:player) { Mastermind::Player.new(name: "Computer") }

  describe "#initialize" do
    it "must have a name" do
      expect{player}.not_to raise_error
      expect{Mastermind::Player.new}.to raise_error ArgumentError
    end
  end
end
