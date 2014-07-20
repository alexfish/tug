module Tug
  class XCTool

    def generate_archive(workspace, scheme, configuration)
      system("xctool -workspace #{workspace} -scheme #{scheme} -configuration #{configuration} archive -archivePath /tmp/#{scheme}.xcarchive")
    end

    def build(workspace, scheme)
      system("xctool -workspace #{workspace} -scheme #{scheme} -sdk iphonesimulator")
    end
  end
end