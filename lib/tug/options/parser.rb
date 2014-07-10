class Parser

  attr_reader :options
  attr_reader :command

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
    @options = parsed_options(options)
    @command = options.shift
  end

  private

  def banner
    "Help!?"
  end

  def parsed_options(options)
    parsed_options_hash = {}

    o = OptionParser.new do |opt|
    end

    begin o.parse! options
    rescue OptionParser::InvalidOption => e
    end

    parsed_options_hash
  end
end