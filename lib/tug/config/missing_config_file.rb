class MissingConfigFile < ConfigFile

  def initialize(path=nil)
    puts "Config file missing"
  end
end