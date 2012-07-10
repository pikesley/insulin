module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  module OnTrack

    # This class represents a set of notes
    class NoteSet < Hash

      # Parse the string 's'
      def initialize s

        # Notes separated by newlines
        l = s.split"\n"

        # For each line
        l.each do |n|

          # Make a note
          x = Note.new n

          # This field will only exists for notes of a valid type
          if x.type

            # If we don't yet have this key
            if not self[x.type]

              # If the content is a list
              if x.content.class.name == "Array"

                # This becomes our value
                self[x.type] = x.content
              else

                # Otherwise make it onto a list
                self[x.type] = [x.content]
              end
            else

              # This key exists, so we append this value
              self[x.type] << x.content
            end
          end
        end
      end
    end
  end
end
