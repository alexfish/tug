require 'spec_helper'

describe Tug::Slack do

  before(:each) do
    ENV['TUG_SLACK_WEBHOOK_TOKEN'] = "slack_token"
    @slack = Tug::Slack.new("#channel", "test_team")

    @command = double(Tug::Command)
    allow(@command).to receive(:notify_text).and_return("hello world")
  end

  describe "when notifying" do
    it "should send a payload to slack with a command notify text" do
      expect(IO).to receive(:popen).with(/"text\":\"hello world\"/)
      @slack.notify(@command)
    end

    it "should send a payload to slack with a username" do
      expect(IO).to receive(:popen).with(/\"username\":\"tug\"/)
      @slack.notify(@command)
    end

    it "should send a payload to slack with an emoji" do
      expect(IO).to receive(:popen).with(/\"icon_emoji\":\":speedboat:\"/)
      @slack.notify(@command)
    end

    it "should send a payload to slack with a color" do
      expect(IO).to receive(:popen).with(/\"color\":\"good\"/)
      @slack.notify(@command)
    end

    it "should send a payload to the correct team" do
      expect(IO).to receive(:popen).with(/test_team.slack.com/)
      @slack.notify(@command)
    end

    it "should send a payload with the webhook token" do
      expect(IO).to receive(:popen).with(/token=slack_token/)
      @slack.notify(@command)
    end
  end
end