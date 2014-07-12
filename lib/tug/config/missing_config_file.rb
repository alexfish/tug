class MissingConfigFile < ConfigFile

  def initialize(path=nil)
    puts "Config file missing 😱\n" +
    "Try specifying a path to your config with the -c option"
    abort
  end

  private

  def abort
    exit 1
  end
end