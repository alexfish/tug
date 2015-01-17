module Tug
  class Slack

    attr_reader   :channel
    attr_reader   :team
    attr_accessor :webhook_token

    def initialize(channel, team)
      @team           = team
      @channel        = channel
      @webhook_token  = ENV['TUG_SLACK_WEBHOOK_TOKEN']
    end

    def notify(command)
      IO.popen("curl #{url} -X POST -# #{params(command)}") do |pipe|
        puts pipe.read
      end
    end

    private

    def url
      "https://#{@team}.slack.com/services/hooks/incoming-webhook?token=#{@webhook_token}"
    end

    def params(command)
      "-F payload='#{payload(command).to_json}'"
    end

    def payload(command)
      {
        "username" => "tug",
        "icon_emoji" => ":speedboat:",
        "channel" => @channel,
        "text" => command.notify_text,
        "color"=> "good",
      }
    end
  end
end