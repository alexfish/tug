require 'spec_helper'

describe Tug::Slack do

  before(:each) do
    ENV['TUG_SLACK_WEBHOOK_TOKEN'] = "slack_token"
    @options = {:team => "slack_team", :channel => "#slack_channel", :webhook_token => "slack_token"}
    @slack = Tug::Slack.new(@options)
  end

  describe "when notifying" do
    it "should send a payload to slack with text" do
      expect(IO).to receive(:popen).with(/"text\":\"text\"/)
      @slack.notify("text")
    end

    it "should send a payload to slack with a username" do
      expect(IO).to receive(:popen).with(/\"username\":\"tug\"/)
      @slack.notify("text")
    end

    it "should send a payload to slack with an emoji" do
      expect(IO).to receive(:popen).with(/\"icon_emoji\":\":speedboat:\"/)
      @slack.notify("text")
    end

    it "should send a payload to slack with a color" do
      expect(IO).to receive(:popen).with(/\"color\":\"good\"/)
      @slack.notify("text")
    end

    it "should send a payload to the correct team" do
      expect(IO).to receive(:popen).with(/slack_team.slack.com/)
      @slack.notify("text")
    end

    it "should send a payload with the webhook token" do
      expect(IO).to receive(:popen).with(/token=slack_token/)
      @slack.notify("text")
    end

    it "should send a payload to the correct channel" do
      expect(IO).to receive(:popen).with(/\"channel\":\"#slack_channel"/)
      @slack.notify("text")
    end

    it "shouldn't send a payload if missing a team" do
      slack = Tug::Slack.new({"foo" => "bar"})
      expect(IO).to_not receive(:popen)
      slack.notify("text")
    end

    it "shouldn't send a payload if missing a channel" do
      slack = Tug::Slack.new({"foo" => "bar"})
      expect(IO).to_not receive(:popen)
      slack.notify("text")
    end

    it "shouldn't send a payload if missing a token" do
      ENV['TUG_SLACK_WEBHOOK_TOKEN'] = nil
      slack = Tug::Slack.new({"foo" => "bar"})
      expect(IO).to_not receive(:popen)
      slack.notify("text")
    end
  end
end