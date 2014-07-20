module Tug
  class XcodeBuild

    def export_ipa(name, profile)
      system("xcodebuild #{archive_options(name)} #{export_options(name)} #{profile_options(profile)}")
    end

    private

    def profile_options(profile)
      "-exportProvisioningProfile #{profile}"
    end

    def export_options(name)
      "-exportPath /tmp/#{name}.ipa -exportFormat ipa -exportArchive"
    end

    def archive_options(name)
      "-archivePath /tmp/#{name}.xcarchive"
    end
  end
end