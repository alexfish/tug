require "spec_helper"

describe Tug::KeychainConfigFile do

  before(:each) do
    file = File.expand_path(File.join(File.dirname(__FILE__), "../lib/tug/config/.tug.yml"))
    config = YAML.load_file(file)
    allow(YAML).to receive(:load_file).and_return(config)
    @config_file = Tug::ConfigFile.new("path")
    @options = {"config" => "path", "keychain" => "keychain", "password" => "password"}
  end

  describe "when returning a config file" do
    it "should set the keychain name" do
      expect(File).to receive(:file?).and_return(true)
      config_file = Tug::ConfigFile.config_file(@options)
      expect(config_file.keychain.name).to match("keychain")
    end

    it "should set the keychain password" do
      expect(File).to receive(:file?).and_return(true)
      config_file = Tug::ConfigFile.config_file(@options)

      expect(config_file.keychain.private_key_password).to match("password")
    end
  end
end
