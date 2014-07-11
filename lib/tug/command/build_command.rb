class BuildCommand < Command

  def execute(options)
    config = ConfigFile.config_file(options[:config])
    puts "build: #{config}"
  end
end