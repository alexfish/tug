module Tug
  class IpaCommand < Command
    def execute(project)
      project.schemes.each do |scheme|
        system("xctool -workspace #{project.workspace} -scheme #{scheme} -configuration #{project.ipa_config} archive -archivePath /tmp/#{scheme}.xcarchive")
        system("xcodebuild -archivePath /tmp/#{scheme}.xcarchive -exportPath /tmp/#{scheme}.ipa -exportFormat ipa -exportArchive")
      end
    end
  end
end