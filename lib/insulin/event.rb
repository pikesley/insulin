module Insulin
  class Event < Hash
    def initialize h
      self.update h
    end

    def save mongo_handle
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
              :upsert => true
            }
          )
        end
      end
    end
  end
end
