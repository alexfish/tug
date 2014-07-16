module Tug
  class Project

    attr_reader :schemes
    attr_reader :workspace
    attr_reader :ipa_config

    def initialize(workspace, schemes, ipa_config)
      @schemes = schemes
      @workspace = workspace
      @ipa_config = ipa_config
    end
  end
end