class BuildCommand < Command

  def execute(options)
    config_file = ConfigFile.config_file(options[:config])
    puts "build: #{config_file.config}"
  end
end