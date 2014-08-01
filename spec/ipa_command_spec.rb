require 'spec_helper'

describe Tug::IpaCommand do

  describe "when executing" do
    before(:each) do
      @command = Tug::IpaCommand.new
      allow_any_instance_of(Tug::XcodeBuild).to receive(:system)
      allow_any_instance_of(Tug::XCTool).to receive(:system)
      allow(FileUtils).to receive(:mv)

      yaml = project_yaml
      yaml["project"]["ipa_config"] = "InHouse"
      @project = Tug::Project.new(yaml)

      @config = double(Tug::ConfigFile)
      allow(@config).to receive(:project).and_return(@project)
    end

    it "should generate an archive using xctool" do
      expect_any_instance_of(Tug::XCTool).to receive(:system).with("xctool -workspace workspace -scheme scheme -configuration InHouse archive -archivePath /tmp/scheme.xcarchive")
      @command.execute(@config)
    end

    it "should export an ipa using xcode build" do
      expect_any_instance_of(Tug::XcodeBuild).to receive(:system).with("xcodebuild -archivePath /tmp/scheme.xcarchive -exportPath /tmp/scheme.ipa -exportFormat ipa -exportArchive -exportWithOriginalSigningIdentity")
      @command.execute(@config)
    end

    it "should move the ipa file into the export path location" do
      @project.ipa_export_path = "/hello/world"
      expect(FileUtils).to receive(:mv).with(anything, /hello\/world/)
      @command.execute(@config)
    end
  end
end