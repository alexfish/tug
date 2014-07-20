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
  end
end