module Tug
  class BuildCommand < Command
    def execute(project)
      xctool = Tug::XCTool.new
      project.schemes.each do |scheme|
        xctool.build(project.workspace, scheme)
      end
    end
  end
end