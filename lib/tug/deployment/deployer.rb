module Tug
  class Deployer

    attr_accessor :ipa
    attr_accessor :api_token
    attr_accessor :team_token

    class << self

      def deployer(config)
        Tug::Deployer.new(config)
      end
    end

    def initialize(config)
    end

    def deploy
      IO.popen("curl #{url} -X POST -# #{params}") do |pipe|
        puts pipe.read
      end
    end

    private

    def url
      "http://testflightapp.com/api/builds.json"
    end

    def notes
      "This build was uploaded via Tug"
    end

    def params
      params = "-F file=@#{ipa} "
      params += "-F team_token='#{team_token}' "
      params += "-F api_token='#{api_token}'"
      params += "-F notes='#{notes}'"
    end
  end
end