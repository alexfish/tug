module Tug
  class ConfigFile

    attr_reader :project

    class << self
      def config_file(path=nil)
        if path and File.file?(path)
          Tug::ConfigFile.new(path)
        else
          Tug::MissingConfigFile.new
        end
      end
    end

    def initialize(path=nil)
      config = YAML::load_file(File.join(Dir.pwd, '.tug.yml'))
      @project = project_from_config(config)
    end

    private

    def project_from_config(config)
      project_yaml = config['project']
      Tug::Project.new(project_yaml['workspace'], project_yaml['schemes'])
    end
  end
end