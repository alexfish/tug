require "spec_helper"

describe Tug::Keychain do 

  before(:each) do
    @yaml = {"apple_certificate" => "apple", 
            "distribution_certificate" => "dist", 
            "distribution_profile" => "path/to/profile", 
            "private_key" => "private", 
            "private_key_password" => "password"}

    @keychain = Tug::Keychain.keychain(@yaml)
    allow(@keychain).to receive(:system)
  end

  describe "when returning keychains" do
    it "should return a keychian" do
    end

    it "should return a protected keychain if password is missing" do
    end
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

    it "should have a default keychain name" do
      expect(@keychain.name).to match("login")
    end
  end

  describe "when importing certificates" do

    it "should create a keychain" do
      expect(@keychain).to receive(:system).with("security create-keychain -p tug login.keychain")
      @keychain.create_keychain
    end

    it "should delete a keychain" do
      expect(@keychain).to receive(:system).with("security delete-keychain login.keychain")
      @keychain.delete_keychain
    end

    it "should import the apple certificate" do
      expect(@keychain).to receive(:system).with("security import apple -k #{File.expand_path('~')}/Library/Keychains/login.keychain -T /usr/bin/codesign")
      @keychain.import_apple_certificate
    end

    it "should import the dist certificate" do
      expect(@keychain).to receive(:system).with("security import dist -k #{File.expand_path('~')}/Library/Keychains/login.keychain -T /usr/bin/codesign")
      @keychain.import_distribution_certificate
    end

    it "should import the private key" do
      @yaml.delete("private_key_password")
      @keychain = Tug::Keychain.keychain(@yaml)

      expect(@keychain).to receive(:system).with("security import private -k #{File.expand_path('~')}/Library/Keychains/login.keychain -T /usr/bin/codesign -P ''")
      @keychain.import_private_key
    end

    it "should import the private key with a password" do
      @yaml["private_key_password"] = "password"
      @keychain = Tug::Keychain.keychain(@yaml)

      expect(@keychain).to receive(:system).with("security import private -k #{File.expand_path('~')}/Library/Keychains/login.keychain -T /usr/bin/codesign -P 'password'")
      @keychain.import_private_key
    end
  end

  describe "when importing profiles" do
 
    it "should import the dist profile" do
      expect(@keychain).to receive(:system).with("cp path/to/profile #{File.expand_path('~')}/Library/MobileDevice/Provisioning\\ Profiles/")
      @keychain.import_profile
    end
  end
end