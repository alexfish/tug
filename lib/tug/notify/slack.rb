module Tug
  class Slack

    attr_reader   :channel
    attr_reader   :team

    def initialize(config)
      if config.has_key?("slack")
        @team           = config["slack"]["team"]
        @channel        = config["slack"]["channel"]
      end
    end

    def notify(text, token=ENV['TUG_SLACK_WEBHOOK_TOKEN'])
      unless @team.nil? || @channel.nil? || token.nil?
        IO.popen("curl #{url(token)} -X POST -# #{params(text)}") do |pipe|
          puts pipe.read
        end
      end
    end

    private

    def url(token)
      "https://#{@team}.slack.com/services/hooks/incoming-webhook?token=#{token}"
    end

    def params(text)
      "-F payload='#{payload(text).to_json}'"
    end

    def payload(text)
      {
        "username" => "tug",
        "icon_emoji" => ":speedboat:",
        "channel" => @channel,
        "text" => text,
        "color"=> "good",
      }
    end
  end
end