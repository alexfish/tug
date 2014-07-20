module Tug
  class IpaCommand < Command
    def execute(project)
      super
      project.schemes.each do |scheme|
        system("xcodebuild -archivePath /tmp/#{scheme}.xcarchive -exportPath /tmp/#{scheme}.ipa -exportFormat ipa -exportArchive -exportProvisioningProfile #{project.ipa_profile}")
      end
    end
  end
end