require "spec_helper"

describe Command do

  before :each do
    @command = Command.new
  end

  describe "when returning a command" do
    it "should return a build command" do
      command = Command.command_for_string("build")
      expect(command).to be_kind_of(BuildCommand)
    end

    it "should return a default command" do
      command = Command.command_for_string("hello")
      expect(command).to be_kind_of(Command)
    end
  end
end
