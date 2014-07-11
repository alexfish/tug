class BuildCommand < Command

  def execute(options)
    config = ConfigFile.new.config
    puts "build: #{config}"
  end
end