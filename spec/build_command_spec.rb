require 'spec_helper'

describe Tug::BuildCommand do

  describe "when executing" do

    before(:each) do
      @xctool = Tug::XCTool.new
      allow(Tug::XCTool).to receive(:new).and_return(@xctool)

      @command = Tug::BuildCommand.new
      allow(@command).to receive(:system)
      @project = Tug::Project.new('workspace', ['scheme'], 'config')
    end

    it "should build using xctool" do
      expect(@xctool).to receive(:system).with("xctool -workspace workspace -scheme scheme -sdk iphonesimulator")
      @command.execute(@project)
    end
  end
end