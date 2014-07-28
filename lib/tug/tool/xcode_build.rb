module Tug
  class XcodeBuild

    def export_ipa(name)
      system("xcodebuild #{archive_options(name)} #{export_options(name)} #{profile_options}")
    end

    private

    def profile_options
      "-exportWithOriginalSigningIdentity"
    end

    def export_options(name)
      "-exportPath /tmp/#{name}.ipa -exportFormat ipa -exportArchive"
    end

    def archive_options(name)
      "-archivePath /tmp/#{name}.xcarchive"
    end
  end
end