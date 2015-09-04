module Tug
  class Testflight < Deployer

    attr_reader :team_token
    attr_reader :lists

    def initialize(options)
      super

      @lists      = options[:lists]
      @team_token = options[:team_token]
    end

    private

    def url
      "http://testflightapp.com/api/builds.json"
    end

    def params
      params = super
      params += "-F \"file=@#{file}\" "
      params += "-F \"api_token=#{api_token}\" "
      params += "-F \"team_token=#{team_token}\" "
      params += "-F \"distribution_lists=#{lists}\" "
    end
  end
end
