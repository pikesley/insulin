module Insulin
  class Event < Hash
    def initialize h
      self.update h
    end

    def save mongo_connection
      clxns = [
        "events",
        self["type"],
        self["subtype"],
        self["date"]
      ]

      clxns.each do |c|
        mongo_connection.db.collection(c).update(
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
