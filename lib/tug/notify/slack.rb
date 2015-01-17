module Tug
  class Slack

    attr_accessor :url

    def initialize(options)
      @url = options[:webhook_url]
    end

    def notify(text)
      unless @url.nil?
        IO.popen("curl #{@url} -X POST -# #{params(text)}") do |pipe|
          puts pipe.read
        end
      end
    end

    private

    def params(text)
      "-F payload='#{payload(text).to_json}'"
    end

    def payload(text)
      {
        "text" => text,
        "color"=> "good",
      }
    end
  end
end