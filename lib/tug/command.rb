class Command

  def execute(*args)
    if args.size == 0
      display_banner
    else
      build
    end
  end

  def display_banner
    "Help Banner"
  end

  def build
    "Building"
  end

end