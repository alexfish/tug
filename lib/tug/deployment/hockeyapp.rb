module Tug
  class Hockeyapp < Deployer

    attr_reader :notes_type
    attr_reader :status
    attr_reader :tags
    attr_reader :teams
    attr_reader :users
    attr_reader :mandatory
    attr_reader :release_type
    attr_reader :private
    attr_reader :commit_sha
    attr_reader :build_server_url
    attr_reader :repository_url

    def initialize(options)
      super

      @notes_type         = options[:notes_type]
      @status             = options[:status]
      @tags               = options[:tags]
      @teams              = options[:teams]
      @users              = options[:users]
      @mandatory          = options[:mandatory]
      @release_type       = options[:release_type]
      @private            = options[:private]
      @commit_sha         = options[:commit_sha]
      @build_server_url   = options[:build_server_url]
      @repository_url     = options[:repository_url]
    end

    private

    def url
      "https://rink.hockeyapp.net/api/2/apps/upload"
    end

    def params
      params = super
      params += "-F \"teams=#{teams}\" "
      params += "-F \"users=#{users}\" "
      params += "-F \"mandatory=#{mandatory}\" "
      params += "-F \"release_type=#{release_type}\" "
      params += "-F \"private=#{private}\" "
      params += "-F \"commit_sha=#{commit_sha}\" "
      params += "-F \"build_server_url=#{build_server_url}\" "
      params += "-F \"repository_url=#{repository_url}\" "
      params += "-F \"tags=#{tags}\" "
      params += "-F \"status=#{status}\" "
      params += "-F \"notes_type=#{notes_type}\" "
      params += "-H \"X-HockeyAppToken: #{api_token}\" "
    end
  end
end