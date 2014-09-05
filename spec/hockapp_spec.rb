require 'spec_helper'

describe Tug::Hockeyapp do

  before(:each) do
    @options = {
      :api_token => "api_token",
      :file => "test.ipa",
      :release_notes => "Notes",
      :notify => 1,
      :notes_type => 1,
      :status => 1,
      :tags => "hello, world",
      :teams => "team",
      :users => "users",
      :mandatory => 0,
      :release_type => 0,
      :private => true,
      :commit_sha => "123",
      :build_server_url => "hello.com",
      :repository_url => "world.com",
      :dsym => "test.zip"
    }

    @deployer = Tug::Hockeyapp.new(@options)
  end

  describe "when deploying" do

    it "should send to hockeyapp" do
      expect(IO).to receive(:popen).with(/https:\/\/rink.hockeyapp.net\/api\/2\/apps\/upload/)
      @deployer.deploy
    end
    
    it "should send the ipa as a param" do
      expect(IO).to receive(:popen).with(/-F "ipa=@test.ipa"/)
      @deployer.deploy
    end

    it "should send the dsym as a param" do
      expect(IO).to receive(:popen).with(/-F dsym=@test.zip/)
      @deployer.deploy
    end

    it "should have some release notes" do
      expect(IO).to receive(:popen).with(/-F notes='Notes'/)
      @deployer.deploy
    end

    it "should have some a notes type" do
      expect(IO).to receive(:popen).with(/-F "notes_type=1"/)
      @deployer.deploy
    end

    it "should have some a status" do
      expect(IO).to receive(:popen).with(/-F "status=1"/)
      @deployer.deploy
    end

    it "should have tags" do
      expect(IO).to receive(:popen).with(/-F "tags=hello, world"/)
      @deployer.deploy
    end

    it "should send the api token as a param" do
      expect(IO).to receive(:popen).with(/-H "X-HockeyAppToken: api_token"/)
      @deployer.deploy
    end

    it "should have teams" do
      expect(IO).to receive(:popen).with(/-F "teams=team"/)
      @deployer.deploy
    end

    it "should have users" do
      expect(IO).to receive(:popen).with(/-F "users=users"/)
      @deployer.deploy
    end

    it "should have a mandatory key" do
      expect(IO).to receive(:popen).with(/-F "mandatory=0"/)
      @deployer.deploy
    end

    it "should have a release_type" do
      expect(IO).to receive(:popen).with(/-F "release_type=0"/)
      @deployer.deploy
    end

    it "should have a private key" do
      expect(IO).to receive(:popen).with(/-F "private=true"/)
      @deployer.deploy
    end

    it "should have a commit_sha" do
      expect(IO).to receive(:popen).with(/-F "commit_sha=123"/)
      @deployer.deploy
    end

    it "should have a build_server_url" do
      expect(IO).to receive(:popen).with(/-F "build_server_url=hello.com"/)
      @deployer.deploy
    end

    it "should have a repository_url" do
      expect(IO).to receive(:popen).with(/-F "repository_url=world.com"/)
      @deployer.deploy
    end
  end
end