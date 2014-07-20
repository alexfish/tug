module Tug
  class Command

    class << self
      def command_for_string(command_string)
        case command_string
        when "build"
          Tug::BuildCommand.new
        when "ipa"
          Tug::IpaCommand.new
        else
          Tug::Command.new
        end
      end
    end

    def execute(project)
    end
  end
end