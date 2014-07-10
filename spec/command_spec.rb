require "spec_helper"

describe Command do

  before :each do
    @command = Command.new
  end

  describe "when called" do
    it "should display a banner when no args are passed" do
      expect(@command).to receive(:display_banner)
      @command.execute
    end

    it "should not display a banner when args are passed" do
      expect(@command).not_to receive(:display_banner)
      @command.execute(["Hello"])
    end

    it "should build" do
      expect(@command).to receive(:build)
      @command.execute(["build"])
    end
  end
end
