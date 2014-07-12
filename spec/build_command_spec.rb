require 'spec_helper'

describe BuildCommand do

  describe "when executing" do

    before(:each) do
      @buld_command = BuildCommand.new
      @project = Project.new('workspace', ['scheme'])
    end

    it "should run xctool" do
      expect(@buld_command).to receive(:system).with(/xctool/)
      @buld_command.build(@project)
    end

    it "should set the workspace" do
      expect(@buld_command).to receive(:system).with(/-workspace workspace/)
      @buld_command.build(@project)
    end

    it "should set the scheme" do
      expect(@buld_command).to receive(:system).with(/-scheme scheme/)
      @buld_command.build(@project)
    end
  end
end