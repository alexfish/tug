class BuildCommand < Command

  def execute(options)
    config_file = ConfigFile.config_file(options[:config])
    build(config_file.project)
  end

  def build(project)
    project.schemes.each do |scheme|
      system("xctool -workspace #{project.workspace} -scheme #{scheme} -sdk iphonesimulator")
    end
  end
end