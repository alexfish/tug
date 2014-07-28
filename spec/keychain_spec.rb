require "spec_helper"

describe Tug::Keychain do 

  before(:each) do
    yaml = {"apple_certificate" => "apple", 
            "distribution_certificate" => "dist", 
            "distribution_profile" => "path/to/profile", 
            "private_key" => "private", 
            "private_key_password" => "password"}

    @keychain = Tug::Keychain.new(yaml)
    allow(@keychain).to receive(:system)
  end

  describe "when created" do
    it "should have a apple certificate" do
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

    it "should have a private key password" do
      expect(@keychain.private_key_password).to be
    end
  end

  describe "when importing certificates" do

    it "should import the apple certificate" do
      expect(@keychain).to receive(:system).with("security import apple -k #{File.expand_path('~')}/Keychains/tug.keychain -T /usr/bin/codesign")
      @keychain.import_apple_certificate
    end

    it "should import the dist certificate" do
      expect(@keychain).to receive(:system).with("security import dist -k #{File.expand_path('~')}/Keychains/tug.keychain -T /usr/bin/codesign")
      @keychain.import_distribution_certificate
    end

    it "should import the private key" do
      expect(@keychain).to receive(:password).and_return(nil)
      expect(@keychain).to receive(:system).with("security import private -k #{File.expand_path('~')}/Keychains/tug.keychain -T /usr/bin/codesign")
      @keychain.import_private_key
    end

    it "should import the private key with a password" do
      expect(@keychain).to receive(:password).and_return("password")
      expect(@keychain).to receive(:system).with("security import private -k #{File.expand_path('~')}/Keychains/tug.keychain -P password -T /usr/bin/codesign")
      @keychain.import_private_key
    end
  end

  describe "when importing profiles" do
    before(:each) do
      allow(FileUtils).to receive(:cp)
    end

    it "should import the dist profile" do
      expect(FileUtils).to receive(:cp).with("path/to/profile", "#{File.expand_path('~')}/Library/MobileDevice/Provisioning\ Profiles/profile")
      @keychain.import_profile
    end
  end
end