require 'spec_helper'

describe Tug::Slack do

  before(:each) do
    @options = {:webhook_url => "slack_url"}
    @slack = Tug::Slack.new(@options)
  end

  describe "when notifying" do
    it "should send a payload to slack with text" do
      expect(IO).to receive(:popen).with(/"text\":\"text\"/)
      @slack.notify("text")
    end

    it "should send a payload to slack with a color" do
      expect(IO).to receive(:popen).with(/\"color\":\"good\"/)
      @slack.notify("text")
    end

    it "should send a payload with the webhook url" do
      expect(IO).to receive(:popen).with(/slack_url/)
      @slack.notify("text")
    end

    it "shouldn't send a payload if missing a url" do
      slack = Tug::Slack.new({"foo" => "bar"})
      expect(IO).to_not receive(:popen)
      slack.notify("text")
    end
  end
end