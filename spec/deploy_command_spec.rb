require 'spec_helper'

describe Tug::DeployCommand do
  describe "when executing" do

    before(:each) do
      @config = double(Tug::ConfigFile)
      @command = Tug::DeployCommand.new
    end

    it "should execute CURL" do
      expect(IO).to receive(:popen).with(/curl/)
      @command.execute(@config)
    end
  end
end