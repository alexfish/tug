require 'spec_helper'

describe Tug::IpaCommand do

  describe "when executing" do
    before(:each) do
      @command = Tug::IpaCommand.new
      @project = Tug::Project.new('workspace', ['scheme'], 'config')
    end

    it "should archive and export" do
      expect(@command).to receive(:system).with(/archive/).twice
      @command.execute(@project)
    end
  end
end