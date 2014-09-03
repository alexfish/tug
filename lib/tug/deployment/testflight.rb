module Tug
  class Testflight < Deployer

    attr_reader :team_token
    attr_reader :lists
    attr_reader :notify

    def initialize(options)
      super

      @lists      = options[:lists]
      @notify     = options[:notify]
      @team_token = options[:team_token]
    end

    private

    def url
      "http://testflightapp.com/api/builds.json"
    end

    def params
      params = super
      params += "-F team_token='#{team_token}' "
      params += "-F distribution_lists='#{lists}' "
      params += "-F notify=#{notify}"
    end
    
  end
end