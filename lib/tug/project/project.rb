module Tug
  class Project

    attr_reader   :schemes
    attr_reader   :workspace
    attr_reader   :ipa_config
    attr_accessor :ipa_export_path

    def initialize(config)
      project_yaml      = config['project']
      @schemes          = project_yaml['schemes']
      @workspace        = project_yaml['workspace']
      @ipa_config       = project_yaml['ipa_config']
      @ipa_export_path  = Dir.pwd
    end
  end
end