module Tug
  class IpaCommand < Command
    def execute(project)
      xctool = Tug::XCTool.tool_for_config(project.ipa_config)
      project.schemes.each do |scheme|
        xctool.build(project.workspace, scheme)
        system("xcodebuild -archivePath /tmp/#{scheme}.xcarchive -exportPath /tmp/#{scheme}.ipa -exportFormat ipa -exportArchive")
      end
    end
  end
end