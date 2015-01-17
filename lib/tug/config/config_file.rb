module Tug
  class ConfigFile

    attr_reader :project
    attr_reader :keychain
    attr_reader :slack

    class << self

      def config_file(options)
        if options.has_key?(:export)
          Tug::IpaConfigFile.config_file(options)
        elsif options.has_key?(:keychain)
          Tug::KeychainConfigFile.config_file(options)
        elsif options.has_key?(:config)
          Tug::ConfigFile.config_file_from_path(options[:config])
        else
          Tug::MissingConfigFile.new
        end
      end

      protected

      def config_file_from_path(path=default_path)
        if path and File.file?(path)
          Tug::ConfigFile.new(path)
        else
          Tug::MissingConfigFile.new
        end
      end
    end

    def initialize(path)
      config    = YAML::load_file(path)
      @project  = Tug::Project.new(config)
      @keychain = Tug::Keychain.keychain(config)
      @slack    = Tug::Slack.new(config)
    end

    private

    def default_path
      File.join(Dir.pwd, '.tug.yml')
    end
  end
end