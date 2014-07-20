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
      @xctool = xctool(project.ipa_config)
      project.schemes.each do |scheme|
        @xctool.build(project.workspace, scheme)
      end
    end

    private

    def xctool(config)
      xctool = Tug::XCTool.tool_for_config(config)
    end
  end
end