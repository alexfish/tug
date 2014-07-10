class EmptyOptionParser < OptionParser

  def parsed_options
    puts "Help: #{options}"
  end

end