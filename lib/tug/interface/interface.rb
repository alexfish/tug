module Tug
  class Interface < Thor

    desc "build", "build a project"
    option :config, :default => "#{Dir.pwd}/.tug.yml"
    def build
      config_file = Tug::ConfigFile.config_file(options[:config])
      execute(__method__.to_s, config_file)
    end

    desc "ipa", "generate an ipa"
    option :config, :default => "#{Dir.pwd}/.tug.yml"
    option :export, :default => "#{Dir.pwd}"
    def ipa
      config_file = Tug::ConfigFile.config_file(options[:config])
      config_file.project.ipa_export_path = options[:export]
      execute(__method__.to_s, config_file)
    end

    desc "provision", "provision system distrubution certificates and provisioning profile"
    def provision
      config_file = Tug::ConfigFile.config_file(options[:config])
      execute(__method__.to_s, config_file)
    end

    no_commands do
      def execute(command, config_file)
        command = Tug::Command.command_for_string(command)
        command.execute(config_file)
      end
    end
  end
end