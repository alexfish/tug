class Command

  def execute(*args)
    parser = OptionParser.new(args)
    build
  end

  def build
    xcode = Xcode.new
    xcode.build
  end

end