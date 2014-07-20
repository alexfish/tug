module Tug
  class XCToolBuild < XCTool

    private

    def build_options(workspace, scheme)
      super + " -sdk iphonesimulator"
    end
  end
end