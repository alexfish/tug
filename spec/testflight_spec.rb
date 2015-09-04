require 'spec_helper'

describe Tug::Testflight do

  before(:each) do
    @options = {
      :api_token => "api_token",
      :team_token => "team_token",
      :file => "test.ipa",
      :notify => true,
      :release_notes => "Notes",
      :dsym => "test.zip"
    }

    @deployer = Tug::Testflight.new(@options)
  end

  describe "when deploying" do

    it "should send to testflight by default" do
      expect(IO).to receive(:popen).with(/http:\/\/testflightapp.com\/api\/builds.json/)
      @deployer.deploy
    end

    it "should send the ipa as a param" do
      expect(IO).to receive(:popen).with(/-F "file=@test.ipa"/)
      @deployer.deploy
    end

    it "should send the dsym as a param" do
      expect(IO).to receive(:popen).with(/-F "dsym=@test.zip"/)
      @deployer.deploy
    end

    it "should send the team token as a param" do
      expect(IO).to receive(:popen).with(/-F "team_token=team_token"/)
      @deployer.deploy
    end

    it "should send the api token as a param" do
      expect(IO).to receive(:popen).with(/-F "api_token=api_token"/)
      @deployer.deploy
    end

    it "should have some release notes" do
      expect(IO).to receive(:popen).with(/-F "notes=<Notes"/)
      @deployer.deploy
    end

    it "should have lists" do
      expect(IO).to receive(:popen).with(/-F "distribution_lists="/)
      @deployer.deploy
    end

    it "should notify" do
      expect(IO).to receive(:popen).with(/-F "notify=true"/)
      @deployer.deploy
    end
  end
end
