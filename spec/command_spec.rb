require "spec_helper"

describe Tug::Command do

  before :each do
    @command = Tug::Command.new
  end

  describe "when returning a command" do
    it "should return an ipa command" do
      command = Tug::Command.command_for_string("ipa")
      expect(command).to be_kind_of(Tug::IpaCommand)
    end

    it "should return a default command" do
      command = Tug::Command.command_for_string("hello")
      expect(command).to be_kind_of(Tug::Command)
    end
  end

  describe "when executing" do

    before(:each) do
      @command = Tug::Command.new
      allow(@command).to receive(:system)
      @project = Tug::Project.new('workspace', ['scheme'], 'Debug')
    end

    it "should build using xctool" do
      expect_any_instance_of(Tug::XCTool).to receive(:system).with("xctool -workspace workspace -scheme scheme -configuration Debug -sdk iphonesimulator")
      @command.execute(@project)
    end
  end
end
