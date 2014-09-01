module Tug
  class XCTool

    attr_reader :config

    class << self
      def tool_for_config(config)
        case config.downcase
        when "inhouse", "release", /release/, /inhouse/
          Tug::XCToolArchive.new(config)
        else
          Tug::XCToolBuild.new(config)
        end
      end
    end

    def initialize(config)
      @config = config
    end

    def build(workspace, scheme)
      system("xctool #{build_options(workspace, scheme)}")
    end

    private

    def build_options(workspace, scheme)
      "-workspace #{workspace} -scheme #{scheme} -configuration #{config}"
    end
  end
end