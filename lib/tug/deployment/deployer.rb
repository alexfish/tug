module Tug
  class Deployer

    attr_accessor :ipa

    class << self

      def deployer(config)
        Tug::Deployer.new(config)
      end
    end

    def initialize(config)
    end

    def deploy
      IO.popen("curl #{url} -X POST -# #{params}") do |pipe|
      end
    end

    private

    def url
      "http://testflightapp.com/api/builds.json"
    end

    def params
      params = "-F file=@#{ipa}"
    end
  end
end