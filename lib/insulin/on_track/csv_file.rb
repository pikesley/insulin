module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  module OnTrack

    # This class represents a CSV file as exported by OnTrack
    class CsvFile
      attr_reader :file, :lines, :events

      # Take the path to the CSV, open it, process it
      def initialize csv_path
        @csv_path = csv_path
        @file = File.new @csv_path
        self.read_lines
        self.create_events
      end

      # Read the lines
      def read_lines
        @lines = []

        # Where an event has more than one note, a 'line' will contain '\n's
        l = ""
        while line = @file.gets
          # Stuff the line in to 'l'
          l << line
  
          # A '"' at the end of the line closes the event
          if line[-2] == '"'
  
            # Create a CsvLine, stripping the final '\n'
            o = CsvLine.new l[0..-2]
            @lines << o
  
            # Reset the placeholder
            l = ""
          end
        end

        # Sort the list by the serial numbers (required for a future feature)
        @lines.sort_by! {|o| o["serial"]}
      end

      # Turn the lines into Events
      def create_events
        @events = []
        @lines.each do |l|
          e = Event.new l
          @events << e
        end
      end

      # Save the events to Mongo
      def save_events mongo
#        print "saving %d events to mongo... " % @events.count
        @events.each do |e|
          e.save mongo
        end
#        puts "done"
      end
    end
  end
end
