module Tug
  class XCToolArchive < XCTool

    private

    def build_options(workspace, scheme)
      super + " archive -archivePath /tmp/#{scheme}.xcarchive"
    end
  end
end