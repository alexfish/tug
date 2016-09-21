module Tug
  class BuildToolBuild < BuildTool

    private

    def build_options(workspace, scheme)
      super + " -sdk iphonesimulator"
    end
  end
end
