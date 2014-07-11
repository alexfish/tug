class ConfigFile

  attr_reader :config

  def initialize
    @config = YAML::load_file(File.join(Dir.pwd, '.tug.yml'))
  end
end