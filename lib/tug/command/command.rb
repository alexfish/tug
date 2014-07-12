class Command

  class << self
    def command_for_string(command_string)
      case command_string
      when "build"
        BuildCommand.new
      else
        Command.new
      end
    end
  end

  def execute(project)
  end
end