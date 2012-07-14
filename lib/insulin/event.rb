require 'time'

module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  # This class represents a single OnTrack event (BG, meds, etc)
  class Event < Hash

    @@units = {
      "glucose" => "mmol/L",
      "medication" => "x10^-5 L",
      "weight" => "kg",
      "exercise" => "minutes",
      "blood pressure" => "sp/df",
      "hba1c" => "%"
    }

# An event before this time is considered part of the previous day. Because
# sometimes, we stay up late
    @@cut_off_time = "04:00"

    # We expect to be passed a hash
    def initialize h
      self.update h

      self["units"] = @@units[self["type"]]
    end

    # Save the event to Mongo via mongo_handle
    def save mongo_handle

# See above
      date_collection = self["date"]
      if self["time"] < @@cut_off_time
        date_collection = (Time.parse(self["date"]) - 86400).strftime "%F"
      end

      # Save to each of these collections
      clxns = [
        "events",
        self["type"],
        self["subtype"],
        date_collection
      ]

      clxns.each do |c|
        if c
          mongo_handle.db.collection(c).update(
            {
              "serial" => self["serial"]
            },
            self,
            {
              # Upsert: update if exists, otherwise insert
              :upsert => true
            }
          )
        end
      end
    end

    def simple
      value_format = "%6.1f"
      if self["value"].is_a? String
        value_format = "%6s"
      end
      s = "%s | %-15s | %-14s | %-13s | #{value_format} %s" % [
        self["short_time"],
        self["tag"],
        self["type"],
        self["subtype"],
        self["value"],
        self["units"]
      ]

      s
    end
  end
end
