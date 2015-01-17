module Tug
  class Slack

    attr_reader   :channel
    attr_reader   :team
    attr_accessor :webhook_token

    def initialize(config)
      if config.has_key?("slack")
        @team           = config["slack"]["team"]
        @channel        = config["slack"]["channel"]
        @webhook_token  = ENV['TUG_SLACK_WEBHOOK_TOKEN']
      end
    end

    def notify(text)
      unless @team.nil? || @channel.nil? || @webhook_token.nil?
        IO.popen("curl #{url} -X POST -# #{params(text)}") do |pipe|
          puts pipe.read
        end
      end
    end

    private

    def url
      "https://#{@team}.slack.com/services/hooks/incoming-webhook?token=#{@webhook_token}"
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