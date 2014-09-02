module Tug
  class Deployer

    attr_reader :ipa
    attr_reader :api_token
    attr_reader :team_token
    attr_reader :lists
    attr_reader :notify
    attr_reader :notes

    class << self
      def deployer(options)
        Tug::Deployer.new(options)
      end
    end

    def initialize(options)
      @ipa        = options[:file]
      @lists      = options[:lists]
      @notify     = options[:notify]
      @api_token  = options[:api_token]
      @team_token = options[:team_token]
      self.notes  = options[:release_notes]
    end

    def deploy
      IO.popen("curl #{url} -X POST -# #{params}") do |pipe|
        puts pipe.read
      end
    end

    def notes=(notes)
      parser = Tug::NotesParser.notes_parser(notes)
      @notes = parser.notes
    end

    private

    def url
      "http://testflightapp.com/api/builds.json"
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