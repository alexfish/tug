require "spec_helper"

describe ConfigFile do

  before(:each) do
    allow(YAML).to receive(:load_file).and_return({:test => "Hello world"})
    @config_file = ConfigFile.new
  end

  describe "when returning a config file" do
    it "should return a config file for no path" do
      config_file = ConfigFile.config_file
      expect(config_file).to be_kind_of(ConfigFile)
    end

    it "should return an external config file for a path" do
      config_file = ConfigFile.config_file("path")
      expect(config_file).to be_kind_of(ExternalConfigFile)
    end
  end

  describe "when loading config" do
    it "should load the yaml config" do
      expect(@config_file.config[:test]).to match("Hello world")
    end
  end
end