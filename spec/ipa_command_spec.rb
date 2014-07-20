require 'spec_helper'

describe Tug::IpaCommand do

  describe "when executing" do
    before(:each) do
      @command = Tug::IpaCommand.new
      allow(@command).to receive(:system)

      yaml = project_yaml
      yaml["ipa_config"] = "InHouse"
      @project = Tug::Project.new(yaml)
    end

    it "should generate an archive using xctool" do
      expect_any_instance_of(Tug::XCTool).to receive(:system).with("xctool -workspace workspace -scheme scheme -configuration InHouse archive -archivePath /tmp/scheme.xcarchive")
      @command.execute(@project)
    end
  end
end