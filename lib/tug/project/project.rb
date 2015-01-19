module Tug
  class Project

    attr_reader   :schemes
    attr_reader   :workspace
    attr_accessor :ipa_config
    attr_accessor :ipa_export_path

    def initialize(config)
      project_yaml      = config['project']
      @schemes          = project_yaml['schemes']
      @workspace        = project_yaml['workspace']
      @ipa_export_path  = Dir.pwd
    end

    def configure(options)
      @ipa_export_path = options["export"]
      @ipa_config = options["build_config"]
    end
  end
end
