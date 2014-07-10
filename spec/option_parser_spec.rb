require "spec_helper"

describe OptionParser do
  describe "when returning parsers" do
    it "should return an option parser for options" do
      parser = OptionParser.parser("options")
      expect(parser).to be_a_kind_of(OptionParser)
    end

    it "should return an empty option parser for no options" do
      parser = OptionParser.parser
      expect(parser).to be_a_kind_of(EmptyOptionParser)
    end
  end
end
