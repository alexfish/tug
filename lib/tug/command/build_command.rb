module Tug
  class BuildCommand < Command
    def execute(project)
      xctool = Tug::XCTool.tool_for_config(project.ipa_config)
      project.schemes.each do |scheme|
        xctool.build(project.workspace, scheme)
      end
    end
  end
end