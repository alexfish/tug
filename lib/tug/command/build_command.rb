class BuildCommand < Command

  def execute(options)
    config_file = ConfigFile.config_file(options[:config])
    build(config_file.config)
  end

  def build(config)
    exec("xctool -workspace #{config['workspace']} -scheme #{config['scheme']}")
  end
end