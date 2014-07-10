class EmptyOptionParser < OptionParser

  def parse
    puts "Help: #{options}"
  end

end