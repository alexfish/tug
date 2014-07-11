class ConfigFile

  attr_reader :config

  class << self
    def config_file(path=nil)
      if path
        ExternalConfigFile.new(path)
      else
        ConfigFile.new
      end
    end
  end

  def initialize(path=nil)
    @config = YAML::load_file(File.join(Dir.pwd, '.tug.yml'))
  end
end