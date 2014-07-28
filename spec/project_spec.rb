require 'spec_helper'

describe Tug::Project do

  describe "when created" do

    before(:each) do
      @project = Tug::Project.new(project_yaml)
    end

    it "should have a workspace" do
      expect(@project.workspace).to match("workspace")
    end

    it "should have a scheme" do
      expect(@project.schemes).to include("scheme")
    end

    it "should have an ipa config" do
      expect(@project.ipa_config).to match("config")
    end

    it "should have an ipa profile" do
      expect(@project.ipa_profile).to match("profile")
    end

    it "should have an ipa export path" do
      expect(@project.ipa_export_path).to be
    end
  end
end