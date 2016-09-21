module Tug
  class IpaCommand < Command

    def execute(config_file)
      super
      export_ipa(config_file.project)
      move_ipa(config_file.project)
      zip_and_move_dsym(config_file.project)
    end

    private

    def export_ipa(project)
      build_tool_export = Tug::BuildToolExport.new
      project.schemes.each do |scheme|
        build_tool_export.export_ipa(scheme)
      end
    end

    def move_ipa(project)
      project.schemes.each do |scheme|
        FileUtils.mv "/tmp/#{scheme}.ipa", "#{project.ipa_export_path}/#{scheme}.ipa"
      end
    end

    def zip_and_move_dsym(project)
      project.schemes.each do |scheme|
        zipfile = zip_file "/tmp/#{scheme}.xcarchive/dSYMs", "#{scheme}.app.dSYM"
        FileUtils.mv zipfile, "#{project.ipa_export_path}/#{scheme}.app.dSYM.zip"
      end
    end

    def zip_file(folder, file)
      file_name = file.split("/").last
      system("cd #{folder} && zip -r #{file + ".zip"} #{file}")

      return folder + "/" + file + ".zip"
    end
  end
end
