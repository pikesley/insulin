require "time"

# OnTrack uses really shitty date formats, including embedding a comma in the
# CSV export file. Christ on a crutch.
module Insulin
  class OnTrackDate < Hash
    def initialize d
      t = Time.parse d
      self["timestamp"] = t
      self["tzoffset"] = t.strftime "%z"
      self["timezone"] = t.zone
      self["unixtime"] = t.to_i
      self["day"] = t.strftime "%A"
      self["date"] = t.strftime "%F"
      self["time"] = t.strftime "%T #{self['timezone']}" 
    end
  end
end
