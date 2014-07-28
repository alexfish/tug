module Tug
  class Interface < Thor

    desc "build", "build a project"
    option :config, :default => "#{Dir.pwd}/.tug.yml"
    def build
      config_file = Tug::ConfigFile.config_file(options[:config])
      execute(__method__.to_s, config_file.project)
    end

    desc "ipa", "generate an ipa"
    option :config, :default => "#{Dir.pwd}/.tug.yml"
    option :export, :default => "#{Dir.pwd}"
    def ipa
      config_file = Tug::ConfigFile.config_file(options[:config])
      project = config_file.project
      project.ipa_export_path = options[:export]
      execute(__method__.to_s, project)
    end

    no_commands do
      def execute(command, project)
        command = Tug::Command.command_for_string(command)
        command.execute(project)
      end
    end
  end
end