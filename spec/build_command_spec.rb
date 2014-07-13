require 'spec_helper'

describe Tug::BuildCommand do

  describe "when executing" do

    before(:each) do
      @build_command = Tug::BuildCommand.new
      @project = Tug::Project.new('workspace', ['scheme'])
    end

    it "should run xctool" do
      expect(@build_command).to receive(:system).with(/xctool/)
      @build_command.execute(@project)
    end

    it "should set the workspace" do
      expect(@build_command).to receive(:system).with(/-workspace workspace/)
      @build_command.execute(@project)
    end

    it "should set the scheme" do
      expect(@build_command).to receive(:system).with(/-scheme scheme/)
      @build_command.execute(@project)
    end
  end
end