require 'insulin'

module Insulin
  class Day < Hash
    def initialize date, mongo
      @date = date
      @mongo = mongo

      keys = [
        "type",
        "subtype",
        "tag"
      ]
      self["all"] = []

      @mongo.db.collection(date).find().each do |e|
        ev = Event.new(e)
        keys.each do |k|
          sub = ev[k]
          if self[sub]
            self[sub] << ev
          else
            self[sub] = [ev]
          end
        end

        self["all"] << ev
      end
    end

    def average_glucose
      t = 0
      c = 0
      begin
        self["glucose"].each do |g|
          @glucose_units = g["units"]
          t += g["value"]
          c += 1
        end
      rescue NoMethodError
        return 0
      end

      return t / c
    end

    def to_s
      s = ""
      s << @date
      s << "\n"

      self["all"].each do |e|
        s << "    "
        s << e.simple
        s << "\n"
      end

      s << "    "
      s << "Average glucose: %4.2f %s" % [
        self.average_glucose,
        @glucose_units
      ]
      s
    end

    def minimal
      s = ""
      s << @date
      s << "\n"

      self["all"].each do |e|
        if ["breakfast", "lunch", "dinner", "bedtime"].include? e["tag"]
          s << "    "
          s << e.simple
          s << "\n"
        end
      end

      s
    end
  end
end
