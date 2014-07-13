module Tug
  class ExternalConfigFile < ConfigFile

    def initialize(path=nil)
      @config = YAML::load_file(path)
    end
  end
end