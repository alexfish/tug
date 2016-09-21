module Tug
  class BuildCommand < Command

    private

    def build_tool(config)
      build_tool = Tug::BuildTool.tool_for_config("Debug")
    end
  end
end
