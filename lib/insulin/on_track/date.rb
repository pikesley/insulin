require "time"

module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT
  module OnTrack

    # OnTrack uses really shitty date formats, including embedding a comma in
    # the CSV export file. Christ on a crutch
    class Date < Hash

      # Parse the string 'd', looking for datetime information
      def initialize d
        t = Time.parse d

        # We extract loads of stuff. Might be useful one day
        self["timestamp"] = t
        self["tzoffset"] = t.strftime "%z"
        self["timezone"] = t.zone
        self["unixtime"] = t.to_i
        self["day"] = t.strftime("%A").downcase
        self["date"] = t.strftime "%F"
        self["time"] = t.strftime "%T #{self['timezone']}" 
        self["short_time"] = t.strftime "%H:%M" 
      end
    end
  end
end
