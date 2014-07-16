module Tug
  class IpaCommand < Command
    def execute(project)
      project.schemes.each do |scheme|
        system("xctool -workspace #{project.workspace} -scheme #{scheme} -configuration #{project.ipa_config}")
      end
    end
  end
end