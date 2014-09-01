module Tug
  class ConfigFile

    attr_reader :project
    attr_reader :keychain
    attr_reader :deployer

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
      @project = Tug::Project.new(config)
      @keychain = Tug::Keychain.keychain(config)
      @deployer = Tug::Deployer.deployer(config)
    end

    private

    def default_path
      File.join(Dir.pwd, '.tug.yml')
    end
  end
end