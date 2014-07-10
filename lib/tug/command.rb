class Command

  def execute(*args)
    parser = OptionParser.parser(args)
    parser.parse
  end

end