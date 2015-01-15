require "spec_helper"

describe Tug::IpaConfigFile do

  before(:each) do
    file = File.expand_path(File.join(File.dirname(__FILE__), "../lib/tug/config/.tug.yml"))
    config = YAML.load_file(file)
    allow(YAML).to receive(:load_file).and_return(config)
    @config_file = Tug::ConfigFile.new("path")
    @options = {:config => "path", :export => "export", :build_config => "config"}
  end

  describe "when returning a config file" do
    it "should set the projects export" do
      expect(File).to receive(:file?).and_return(true)
      config_file = Tug::ConfigFile.config_file(@options)
      expect(config_file.project.ipa_export_path).to match("export")
    end

    it "should set the projects build config" do
      expect(File).to receive(:file?).and_return(true)
      config_file = Tug::ConfigFile.config_file(@options)

      expect(config_file.project.ipa_config).to match("config")
    end
  end
end