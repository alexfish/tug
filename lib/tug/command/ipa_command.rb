module Tug
  class IpaCommand < Command

    def execute(config_file)
      super
      export_ipa(config_file.project)
      move_ipa(config_file.project)
    end

    private

    def export_ipa(project)
      xcodebuild = Tug::XcodeBuild.new
      project.schemes.each do |scheme|
        xcodebuild.export_ipa(scheme)
      end
    end

    def move_ipa(project)
      project.schemes.each do |scheme|
        FileUtils.mv "/tmp/#{scheme}.ipa", "#{project.ipa_export_path}/#{scheme}.ipa"
      end
    end
  end
end