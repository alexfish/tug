module Tug

  class NotesFileParser < NotesParser

    def initialize(notes)
      file = File.open(notes)
      @notes = file.read
    end
  end
end