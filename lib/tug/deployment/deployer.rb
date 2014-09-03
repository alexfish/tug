module Tug
  class Deployer

    attr_reader :file
    attr_reader :api_token
    attr_reader :notes
    attr_reader :notify

    def initialize(options)
      @file       = options[:file]
      @api_token  = options[:api_token]
      @notify     = options[:notify]

      self.notes   = options[:release_notes]
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
      ""
    end

    def params
      params = "-F notes='#{notes}' "
      params += "-F notify=#{notify} "
    end
  end
end