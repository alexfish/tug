class Parser

  attr_reader :options

  class << self
    def parser_for_args(options=nil)
      if options
        Parser.new(options)
      else
        EmptyParser.new
      end
    end
  end

  def initialize(options=nil)
    @options = options
  end

  def parsed_options
    parsed_options_hash = {}

    o = OptionParser.new do |opt|
      opt.on("-c","--command COMMAND", "the command to run") do |command|
        parsed_options_hash[:command] = command
      end
    end

    begin o.parse! options
    rescue OptionParser::InvalidOption => e
    end

    parsed_options_hash
  end
end