require 'spec_helper'

describe BuildCommand do

  describe "when executing" do

    before(:each) do
      @buld_command = BuildCommand.new
    end

    it "should run xctool" do
      expect(@buld_command).to receive(:exec).with(/xctool/)
      @buld_command.build({})
    end

    it "should set the workspace" do
      expect(@buld_command).to receive(:exec).with(/-workspace test/)
      @buld_command.build({"workspace" => "test"})
    end

    it "should set the scheme" do
      expect(@buld_command).to receive(:exec).with(/-scheme test/)
      @buld_command.build({"scheme" => "test"})
    end
  end
end