class ConfigFile

  attr_reader :config

  class << self
    def config_file(path=nil)
      if path and File.file?(path)
        ExternalConfigFile.new(path)
      elsif File.file?(File.join(Dir.pwd, '.tug.yml'))
        ConfigFile.new
      else
        MissingConfigFile.new
      end
    end
  end

  def initialize(path=nil)
    @config = YAML::load_file(File.join(Dir.pwd, '.tug.yml'))
  end
end