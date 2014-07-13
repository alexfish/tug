module Tug
  class BuildCommand < Command

    def execute(project)
      project.schemes.each do |scheme|
        system("xctool -workspace #{project.workspace} -scheme #{scheme} -sdk iphonesimulator")
      end
    end
  end
end