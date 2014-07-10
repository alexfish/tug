require "spec_helper"

describe Parser do
  describe "when returning parsers" do
    it "should return an option parser for options" do
      parser = Parser.parser_for_args(["options"])
      expect(parser).to be_a_kind_of(Parser)
    end

    it "should return an empty option parser for no options" do
      parser = Parser.parser_for_args
      expect(parser).to be_a_kind_of(EmptyParser)
    end
  end

  describe "when parsing options" do
    it "should parse the command" do
      parser = Parser.parser_for_args(["build"])
      expect(parser.command).to match("build")
    end
  end
end
