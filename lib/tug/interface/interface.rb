def Interface < Thor

  desc "build", "build a project"
  option :config
  def build(config=nil)
    config_file = ConfigFile.config_file(options[:config])
    command = BuildCommand.new
    command.build(config_file.project)
  end
end
