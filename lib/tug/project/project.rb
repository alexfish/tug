module Tug
  class Project

    attr_reader :schemes
    attr_reader :workspace
    attr_reader :ipa_config
    attr_reader :ipa_profile

    def initialize(project_yaml)
      @schemes = project_yaml['schemes']
      @workspace = project_yaml['workspace']
      @ipa_config = project_yaml['ipa_config']
      @ipa_profile = project_yaml['ipa_profile']
    end
  end
end