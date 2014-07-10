require "spec_helper"

describe Command do

  before :each do
    @command = Command.new
  end

  describe "when called" do
    it "should build" do
      expect(@command).to receive(:build)
      @command.execute(["build"])
    end
  end
end
