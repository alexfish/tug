require "spec_helper"

describe ConfigFile do

  before(:each) do
    allow(YAML).to receive(:load_file).and_return({:test => "Hello world"})
    @config_file = ConfigFile.new
  end

  describe "when loading config" do
    it "should load the yaml config" do
      expect(@config_file.config[:test]).to match("Hello world")
    end
  end
end