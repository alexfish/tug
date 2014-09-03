require 'spec_helper'

describe Tug::Deployer do

  before(:each) do
    @options = {
      :api_token => "api_token",
      :file => "test.ipa",
      :release_notes => "Notes",
      :notify => 1
    }

    @deployer = Tug::Deployer.new(@options)
  end

  describe "when deploying" do

    it "should have some release notes" do
      expect(IO).to receive(:popen).with(/-F notes='Notes'/)
      @deployer.deploy
    end

    it "should notify" do
      expect(IO).to receive(:popen).with(/-F notify=1/)
      @deployer.deploy
    end
  end
end