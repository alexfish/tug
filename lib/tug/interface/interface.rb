class Interface < Thor

  desc "build", "build a project"
  option :config
  def build(config=nil)
    config_file = ConfigFile.config_file(options[:config])
    execute(__method__.to_s, config_file.project)
  end

  no_commands do
    def execute(command, project)
      command = Command.command_from_string(command)
      command.execute(project)
    end
  end
end
