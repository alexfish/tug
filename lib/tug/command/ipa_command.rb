module Tug
  class IpaCommand < Command

    def execute(project)
      super
      xcodebuild = Tug::XcodeBuild.new
      project.schemes.each do |scheme|
        xcodebuild.export_ipa(scheme, project.ipa_profile)
      end
    end
  end
end