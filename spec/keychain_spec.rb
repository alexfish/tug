require "spec_helper"

describe Tug::Keychain do

  before(:each) do
    @yaml = keychain_yaml

    @keychain = Tug::Keychain.keychain(@yaml)
    @keychain.name = "tug"

    allow(@keychain).to receive(:system)
    allow(@keychain).to receive(:`)
  end

  describe "when returning keychains" do
    it "should return a keychain" do
      expect(@keychain).to be
    end

    it "shouldn't return one for invalid config" do
      expect(Tug::Keychain.keychain({})).to be_nil
    end
  end

  describe "when created" do
    it "should have an apple certificate" do
      expect(@keychain.apple_certificate).to be
    end

    it "should have a distribution certificate" do
      expect(@keychain.distribution_certificate).to be
    end

    it "should have a distribution profile" do
      expect(@keychain.distribution_profile).to be
    end

    it "should have a private key" do
      expect(@keychain.private_key).to be
    end

    it "should have a default keychain name" do
      expect(@keychain.name).to match("tug")
    end

    it "should know what the current keychain is" do
      allow(@keychain).to receive(:`).and_return("    \"/Users/user/Library/Keychains/hi.keychain\"\n")
      expect(@keychain.default_keychain_name).to match("hi")
    end
  end

  describe "when importing certificates" do

    it "should select a keychain" do
      expect(@keychain).to receive(:system).with("security default-keychain -s test.keychain")
      @keychain.select_keychain("test")
    end

    it "should create a keychain" do
      expect(@keychain).to receive(:system).with("security create-keychain -p tug tug.keychain")
      @keychain.create_keychain
    end

    it "should delete a keychain" do
      expect(@keychain).to receive(:system).with("security delete-keychain tug.keychain")
      @keychain.delete_keychain
    end

    it "should unlock the keychain" do
      expect(@keychain).to receive(:system).with("security unlock-keychain -p tug tug.keychain")
      @keychain.unlock_keychain
    end

    it "should set a timeout" do
      expect(@keychain).to receive(:system).with("security set-keychain-settings -t 3600 -u tug.keychain")
      @keychain.set_timeout
    end

    it "should import the apple certificate" do
      expect(@keychain).to receive(:system).with("security import apple -k #{File.expand_path('~')}/Library/Keychains/tug.keychain -T /usr/bin/codesign")
      @keychain.import_apple_certificate
    end

    it "should import the dist certificate" do
      expect(@keychain).to receive(:system).with("security import dist -k #{File.expand_path('~')}/Library/Keychains/tug.keychain -T /usr/bin/codesign")
      @keychain.import_distribution_certificate
    end

    it "should import the private key" do
      ENV['TUG_P12_PASSWORD'] = nil
      @keychain = Tug::Keychain.keychain(@yaml)
      @keychain.name = "tug"

      expect(@keychain).to receive(:system).with("security import private -k #{File.expand_path('~')}/Library/Keychains/tug.keychain -T /usr/bin/codesign -P ''")
      @keychain.import_private_key
    end

    it "should import the private key with a password via env var" do
      ENV['TUG_P12_PASSWORD'] = "password"
      @keychain = Tug::Keychain.keychain(@yaml)
      @keychain.name = "tug"

      expect(@keychain).to receive(:system).with("security import private -k #{File.expand_path('~')}/Library/Keychains/tug.keychain -T /usr/bin/codesign -P 'password'")
      @keychain.import_private_key
    end

    it "should import the private key with a password via setter" do
      @keychain = Tug::Keychain.keychain(@yaml)
      @keychain.private_key_password = "hello"
      @keychain.name = "tug"

      expect(@keychain).to receive(:system).with("security import private -k #{File.expand_path('~')}/Library/Keychains/tug.keychain -T /usr/bin/codesign -P 'hello'")
      @keychain.import_private_key
    end
  end

  describe "when importing profiles" do
  
    before(:each) do
      allow(FileUtils).to receive(:mkdir_p)
    end

    it "should create a profile folder" do
      expect(FileUtils).to receive(:mkdir_p).with("#{File.expand_path('~')}/Library/MobileDevice/Provisioning\ Profiles/")
      @keychain.import_profile
    end

    it "should import the dist profile" do
      expect(@keychain).to receive(:system).with("cp path/to/profile #{File.expand_path('~')}/Library/MobileDevice/Provisioning\\ Profiles/")
      @keychain.import_profile
    end
  end
end