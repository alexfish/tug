require 'spec_helper'

describe Tug::NotesFileParser do

  describe "When parsing notes" do

    it "should parse notes from a file" do
      parser = Tug::NotesFileParser.new(release_notes_path)
      expect(parser.notes).to match("Hello World")
    end

    it "should parse notes with sepcial characters" do
      parser = Tug::NotesFileParser.new(special_release_notes_path)
      expect(parser.notes).to match("#Hello World's")
    end
  end
end