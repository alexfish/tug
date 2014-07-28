module Tug
  class ConfigFile

    attr_reader :project

    class << self
      def config_file(path=default_path)
        if path and File.file?(path)
          Tug::ConfigFile.new(path)
        else
          Tug::MissingConfigFile.new
        end
      end
    end

    def initialize(path)
      config = YAML::load_file(path)
      @project = Tug::Project.new(config['project'])
    end

    private

    def default_path
      File.join(Dir.pwd, '.tug.yml')
    end
  end
end