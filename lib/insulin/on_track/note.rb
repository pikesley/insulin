module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  # Class representing a single OnTrack note
  class OnTrackNote

    # Lookups. We will only deal with notes of these types
    @@keys = {
      "F" => 'food',
      "B" => 'booze',
      "N" => 'note'
    }

    attr_reader :type, :content

    # Parse the raw note 'n'
    def initialize n

      # Key/value splits on ':'
      bits = n.split ":"

      # Remove leading/trailing cruft from key part
      t = bits[0].strip

      # We only deal with the keys we know about
      if @@keys.keys.include? t

        # Remove cruft from content, downcase
        @content = bits[1].strip.downcase

        # These keys mean we turn the content into a list
        if ["F", "B"].include? t
          a = []
          @content.split(",").each do |v|
            a << v.strip
          end
          @content = a
        end

        # Set key from lookup list
        @type = @@keys[t]
      end
    end
  end
end
