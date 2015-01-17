module Tug
  class Command

    class << self
      def command_for_string(command_string)
        case command_string
        when "build"
          Tug::BuildCommand.new
        when "ipa"
          Tug::IpaCommand.new
        when "provision"
          Tug::ProvisionCommand.new
        when "deploy"
          Tug::DeployCommand.new
        else
          Tug::Command.new
        end
      end
    end

    def execute(config_file)
      project = config_file.project
      @xctool = xctool(project.ipa_config)
      project.schemes.each do |scheme|
        @xctool.build(project.workspace, scheme)
      end
    end

    def notify_text
      "Command completed :+1:"
    end

    private

    def xctool(config)
      xctool = Tug::XCTool.tool_for_config(config)
    end
  end
end