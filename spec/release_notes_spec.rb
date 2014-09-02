require 'spec_helper'

describe Tug::NotesParser do
  
  describe "When returning a parser" do

    it "should return a notes parser for plain text notes" do
      expect(File).to receive(:file?).and_return(false)
      expect(Tug::NotesParser.notes_parser("test")).to be_kind_of(Tug::NotesParser)
    end

    it "should return a notes file parser for file notes" do
      expect(File).to receive(:file?).and_return(true)

      file = double(File)
      expect(file).to receive(:read)
      expect(File).to receive(:open).and_return(file)
      
      expect(Tug::NotesParser.notes_parser("test")).to be_kind_of(Tug::NotesFileParser)
    end
  end
end