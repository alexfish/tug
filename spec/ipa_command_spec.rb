require 'spec_helper'

describe Tug::IpaCommand do

  describe "when executing" do
    before(:each) do
      @xctool = Tug::XCTool.new
      allow(Tug::XCTool).to receive(:new).and_return(@xctool)

      @command = Tug::IpaCommand.new
      allow(@command).to receive(:system)
      @project = Tug::Project.new('workspace', ['scheme'], 'config')
    end

    it "should generate an archive using xctool" do
      expect(@xctool).to receive(:system).with("xctool -workspace workspace -scheme scheme -configuration config archive -archivePath /tmp/scheme.xcarchive")
      @command.execute(@project)
    end
  end
end