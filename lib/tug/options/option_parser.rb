class OptionParser

  attr_reader :options

  class << self
    def parser(options=nil)
      if options
        OptionParser.new(options)
      else
        EmptyOptionParser.new
      end
    end
  end

  def initialize(options=nil)
    @options = options
  end

  def parse
    puts "Parse"
  end
end