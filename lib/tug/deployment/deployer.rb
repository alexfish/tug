module Tug
  class Deployer

    attr_reader :file
    attr_reader :dsym
    attr_reader :api_token
    attr_reader :notes
    attr_reader :notify

    def initialize(options)
      @file       = options[:file]
      @api_token  = options[:api_token]
      @notify     = options[:notify]
      @dsym       = options[:dsym]
      @notes      = options[:release_notes]
    end

    def deploy
      IO.popen("curl #{url} -X POST -# #{params}") do |pipe|
        puts pipe.read
      end
    end

    private

    def url
      ""
    end

    def params
      params  = "-F \"notes=<#{notes}\" "
      params += "-F \"dsym=@#{dsym}\" "
      params += "-F \"notify=#{notify}\" "
    end
  end
end
