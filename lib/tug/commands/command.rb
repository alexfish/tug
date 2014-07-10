class Command

  def execute(*args)
    parser = OptionParser.new(args)
    parser.parse
  end

  def build
    xcode = Xcode.new
    xcode.build
  end
end