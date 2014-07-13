require 'spec_helper'

describe Tug::Project do

  describe "when created" do

    before(:each) do
      @project = Tug::Project.new("workspace", ["scheme"])
    end

    it "should have a workspace" do
      expect(@project.workspace).to match("workspace")
    end

    it "should have a scheme" do
      expect(@project.schemes).to include("scheme")
    end
  end
end