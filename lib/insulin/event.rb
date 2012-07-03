module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  # This class represents a single OnTrack event (BG, meds, etc)
  class Event < Hash

    @@units = {
      "glucose" => "mmol/L",
      "medication" => "x10^-5 L",
      "weight" => "kg",
      "exercise" => "minutes"
    }

    # We expect to be passed a hash
    def initialize h
      self.update h

      self["units"] = @@units[self["type"]]
    end

    # Save the event to Mongo via mongo_handle
    def save mongo_handle

      # Save to each of these collections
      clxns = [
        "events",
        self["type"],
        self["subtype"],
        self["date"]
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
  end
end
