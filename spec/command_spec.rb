require "spec_helper"

describe Tug::Command do

  before :each do
    @command = Tug::Command.new
  end

  describe "when returning a command" do
    it "should return a build command" do
      command = Tug::Command.command_for_string("build")
      expect(command).to be_kind_of(Tug::BuildCommand)
    end

    it "should return an ipa command" do
      command = Tug::Command.command_for_string("ipa")
      expect(command).to be_kind_of(Tug::IpaCommand)
    end

    it "should return a default command" do
      command = Tug::Command.command_for_string("hello")
      expect(command).to be_kind_of(Tug::Command)
    end

    it "should return a provision command" do
      command = Tug::Command.command_for_string("provision")
      expect(command).to be_kind_of(Tug::ProvisionCommand)
    end

    it "should have a default notify text" do
      expect(@command.notify_text).to match("Command completed :+1:")
    end
  end
end
