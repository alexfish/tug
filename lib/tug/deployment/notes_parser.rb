module Tug
  class NotesParser

    attr_reader :notes

    class << self
      def notes_parser(notes)
        if File.file? notes
          Tug::NotesFileParser.new(notes)
        else
          Tug::NotesParser.new(notes)
        end
      end
    end

    def initialize(notes)
      @notes = notes
    end
  end
end