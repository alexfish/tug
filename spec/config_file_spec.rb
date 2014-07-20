require "spec_helper"

describe Tug::ConfigFile do

  before(:each) do
    config = {'project' => {'workspace' => 'hello', 'schemes' => ["world"], 'ipa_config' => 'config'}}
    allow(YAML).to receive(:load_file).and_return(config)
    @config_file = Tug::ConfigFile.new("path")
  end

  describe "when returning a config file" do
    it "should return a config file for a path" do
      expect(File).to receive(:file?).and_return(true)
      config_file = Tug::ConfigFile.config_file("path")
      expect(config_file).to be_kind_of(Tug::ConfigFile)
    end

    it "should return a missing config file for no file found" do
      allow_any_instance_of(Tug::MissingConfigFile).to receive(:abort)
      expect(File).to receive(:file?).and_return(false)
      config_file = Tug::ConfigFile.config_file("path")
      expect(config_file).to be_kind_of(Tug::MissingConfigFile)
    end
  end

  describe "when loading config" do
    it "should load a project" do
      expect(@config_file.project).to be
    end
  end
end