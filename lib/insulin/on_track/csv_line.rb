module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  module OnTrack

    # This class represents a single OnTrack CSV line
    class CsvLine < Hash

      # Parse the passed-in CSV line
      def initialize line

        # Split on commas 
        bits = line.split ","
        self["serial"] = bits[0].to_i

        # OnTrack embeds commas in the dates of its CSVs. Duh 
        self.update Date.new "%s%s" % [
          bits[1],
          bits[2]
        ]
        self["type"] = bits[3].downcase
        self["subtype"] = bits[4].downcase if not bits[4] == ""
        self["tag"] = bits[5].downcase
        self["value"] = bits[6].to_f

        # Notes get complicated. Everything from field 7 to the end will be part
        # of the notes
        notes = bits[7..-1]

        # We may have embedded commas
        notes = notes.join ","
  
        # Strip the trailing '\n'
        notes = notes[1..-2]

        # See Insulin::OnTrack::NoteSet
        self["notes"] = NoteSet.new notes if not notes == ""
      end
    end
  end
end
