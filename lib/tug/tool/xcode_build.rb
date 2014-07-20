module Tug
  class XcodeBuild

    def export_ipa(name, profile)
      system("xcodebuild -archivePath /tmp/#{name}.xcarchive -exportPath /tmp/#{name}.ipa -exportFormat ipa -exportArchive -exportProvisioningProfile #{profile}")
    end
  end
end