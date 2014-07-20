module Tug
  class IpaCommand < Command
    def execute(project)
      xctool = Tug::XCTool.new
      project.schemes.each do |scheme|
        xctool.generate_archive(project.workspace, scheme, project.ipa_config)
        system("xcodebuild -archivePath /tmp/#{scheme}.xcarchive -exportPath /tmp/#{scheme}.ipa -exportFormat ipa -exportArchive")
      end
    end
  end
end