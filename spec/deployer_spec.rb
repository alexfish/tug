require 'spec_helper'

describe Tug::Deployer do

  before(:each) do
    @config = double(Tug::ConfigFile)
    @deployer = Tug::Deployer.deployer(@config)
  end

  describe "when returning a deployer" do
    it "should return a default deployer" do
      expect(Tug::Deployer.deployer(@config)).to be_kind_of(Tug::Deployer)
    end
  end

  describe "when created" do
    it "should take an ipa attribute" do
      ipa = "test.ipa"
      @deployer.ipa = ipa

      expect(@deployer.ipa).to equal(ipa)
    end
  end

  describe "when deploying" do

    before(:each) do
      @deployer.ipa = "test.ipa"
    end

    it "should send to testflight by default" do
      expect(IO).to receive(:popen).with(/http:\/\/testflightapp.com\/api\/builds.json/)
      @deployer.deploy
    end

    it "should send the ipa as a param" do
      expect(IO).to receive(:popen).with(/-F file=@test.ipa/)
      @deployer.deploy
    end
  end
end