module Tug
  class Deployer

    attr_accessor :ipa
    attr_accessor :api_token
    attr_accessor :team_token
    attr_accessor :lists
    attr_accessor :notify

    class << self
      def deployer(config)
        Tug::Deployer.new(config)
      end
    end

    def initialize(config)
      @lists = ""
      @notify = false
      @api_token = ENV['TUG_TESTFLIGHT_API_TOKEN']
      @team_token = ENV['TUG_TESTFLIGHT_TEAM_TOKEN']
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
      params += "-F api_token='#{api_token}' "
      params += "-F team_token='#{team_token}' "
      params += "-F notes='#{notes}' "
      params += "-F distribution_lists='#{lists}' "
      params += "-F notify=#{notify}"
    end
  end
end