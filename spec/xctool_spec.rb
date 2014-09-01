require 'spec_helper'

describe Tug::XCTool do
  describe "when returning an xctool" do
    it "should return a build tool" do
      xctool = Tug::XCTool.tool_for_config("Debug")
      expect(xctool).to be_kind_of(Tug::XCToolBuild)
    end

    it "should return an archive tool" do
      xctool = Tug::XCTool.tool_for_config("InHouse")
      expect(xctool).to be_kind_of(Tug::XCToolArchive)
    end

    it "should return an archive tool when release is in the config" do
      xctool = Tug::XCTool.tool_for_config("TestRelease")
      expect(xctool).to be_kind_of(Tug::XCToolArchive)
    end

    it "should return an archive tool when inhouse is in the config" do
      xctool = Tug::XCTool.tool_for_config("TestInHouse")
      expect(xctool).to be_kind_of(Tug::XCToolArchive)
    end
  end
end