require 'spec_helper'

describe Tug::IpaCommand do

  describe "when executing" do
    before(:each) do
      @command = Tug::IpaCommand.new
      @project = Tug::Project.new('workspace', ['scheme'], 'config')
    end

    it "should use the project's ipa config setting" do
      expect(@command).to receive(:system).with(/config/)
      @command.execute(@project)
    end

    it "should build using the archive command" do
      expect(@command).to receive(:system).with(/archive/)
      @command.execute(@project)
    end
  end
end