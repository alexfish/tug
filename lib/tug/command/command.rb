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
      @build_tool = build_tool(project.ipa_config)
      project.schemes.each do |scheme|
        @build_tool.build(project.workspace, scheme)
      end
    end

    private

    def build_tool(config)
      build_tool = Tug::BuildTool.tool_for_config(config)
    end
  end
end
