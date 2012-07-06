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
        ev = Insulin::Event.new(e)
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
      self["glucose"].each do |g|
        t += g["value"]
        c += 1
      end

      return t / c
    end

    def to_s
      s = @date
      s << "\n"
      s << "\n"

      @widths = {}
      self["all"].each do |e|
        e.keys.each do |k|
          if not @widths[k]
            @widths[k] = e[k].to_s.size
          else
            if e[k].to_s.size > @widths[k]
              @widths[k] = e[k].to_s.size
            end
          end
        end
      end

      self["all"].each do |e|
        t = "%-#{@widths['time']}s %-#{@widths['type']}s %-#{@widths['subtype']}s %4.1f %-#{@widths["units"]}s" % [
          e["time"],
          e["type"],
          e["subtype"],
          e["value"],
          e["units"]
        ]

        s << t
        s << "\n"
      end
      s << "\n"

      s << "Average glucose: %4.2f" % self.average_glucose
      s
    end
  end
end
