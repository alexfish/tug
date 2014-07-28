module Tug
  class BuildCommand < Command

    private

    def xctool(config)
      xctool = Tug::XCTool.tool_for_config("Debug")
    end
  end
end