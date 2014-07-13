module Tug
  class Project

    attr_reader :schemes
    attr_reader :workspace

    def initialize(workspace, schemes)
      @schemes = schemes
      @workspace = workspace
    end
  end
end