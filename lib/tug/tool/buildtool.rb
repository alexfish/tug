module Tug
  class BuildTool

    attr_reader :config

    class << self
      def tool_for_config(config)
        case config.downcase
        when "inhouse", "release", /release/, /inhouse/
          Tug::BuildToolArchive.new(config)
        else
          Tug::BuildToolBuild.new(config)
        end
      end
    end

    def initialize(config)
      @config = config
    end

    def build(workspace, scheme)
      system("xcodebuild #{build_options(workspace, scheme)}")
    end

    private

    def build_options(workspace, scheme)
      "-workspace #{workspace} -scheme #{scheme} -configuration #{config}"
    end
  end
end
