require 'spec_helper'

describe Tug::Deployer do

  before(:each) do
    @options = {
      :api_token => "api_token",
      :file => "test.ipa",
      :release_notes => "Notes"
    }

    @deployer = Tug::Deployer.deployer(@options)
  end

  describe "when returning a deployer" do
    it "should return a default deployer" do
      expect(Tug::Deployer.deployer(@options)).to be_kind_of(Tug::Deployer)
    end

    it "should return a testflight deployer" do
      @options[:team_token] = "testflight_token"
      expect(Tug::Deployer.deployer(@options)).to be_kind_of(Tug::Testflight)
    end
  end

  describe "when deploying" do

    it "should send the ipa as a param" do
      expect(IO).to receive(:popen).with(/-F file=@test.ipa/)
      @deployer.deploy
    end

    it "should send the api token as a param" do
      expect(IO).to receive(:popen).with(/-F api_token='api_token'/)
      @deployer.deploy
    end

    it "should have some release notes" do
      expect(IO).to receive(:popen).with(/-F notes='Notes'/)
      @deployer.deploy
    end
  end
end