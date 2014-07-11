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
    @command = options.shift
    @options = parsed_options(options)
  end

  private

  def banner
    "Help!?"
  end

  def parsed_options(options)
    parsed_options = {}

    o = OptionParser.new do |opts|
      opts.on("-c", "--config CONFIG", "Configuration file path") do |config|
        parsed_options[:config] = config
      end
    end

    begin o.parse! options
    rescue OptionParser::InvalidOption => e
      puts banner
    end

    parsed_options
  end
end