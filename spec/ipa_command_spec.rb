require 'spec_helper'

describe Tug::IpaCommand do

  describe "when executing" do
    before(:each) do
      @command = Tug::IpaCommand.new
      allow_any_instance_of(Tug::XcodeBuild).to receive(:system)
      allow_any_instance_of(Tug::XCTool).to receive(:system)
      allow(FileUtils).to receive(:mv)
      allow(@command).to receive(:system)

      yaml = project_yaml
      @project = Tug::Project.new(yaml)
      @project.ipa_config = "InHouse"

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

    it "should zip the dsym" do
      expect(@command).to receive(:system).with(/zip -r scheme.app.dSYM.zip scheme.app.dSYM/)
      @command.execute(@config)
    end

    it "should move the zipped dsym file into the export path location" do
      @project.ipa_export_path = "/hello/world"
      expect(FileUtils).to receive(:mv).with(/scheme.app.dSYM.zip/, /hello\/world/)
      @command.execute(@config)
    end

    it "should move the ipa file into the export path location" do
      @project.ipa_export_path = "/hello/world"
      expect(FileUtils).to receive(:mv).with(/scheme.ipa/, /hello\/world/)
      @command.execute(@config)
    end
  end
end