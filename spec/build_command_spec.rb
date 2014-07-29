require 'spec_helper'

describe Tug::BuildCommand do

  describe "when executing" do

    before(:each) do
      @command = Tug::BuildCommand.new
      allow(@command).to receive(:system)
      @project = Tug::Project.new(project_yaml)

      @config = double(Tug::ConfigFile)
      allow(@config).to receive(:project).and_return(@project)
    end

    it "should build using xctool" do
      expect_any_instance_of(Tug::XCTool).to receive(:system).with("xctool -workspace workspace -scheme scheme -configuration Debug -sdk iphonesimulator")
      @command.execute(@config)
    end
  end
end