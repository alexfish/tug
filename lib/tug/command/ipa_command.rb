module Tug
  class IpaCommand < Command

    def execute(project)
      super
      project.schemes.each do |scheme|
        system("xcodebuild -archivePath /tmp/#{scheme}.xcarchive -exportPath /tmp/#{scheme}.ipa -exportFormat ipa -exportArchive")
      end
    end
  end
end