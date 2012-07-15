require 'insulin'
require 'time'

module Insulin
  class NDayPeriod < Array
    def initialize hash
      @start_date = hash["start_date"]
      @days = hash["days"]
      @mongo = hash["mongo"]

      t = Time.parse @start_date
      today = Time.new
      @count = 0
      @days.times do |i|
        d = (t + (i * 86400))
        if d <= today
          day = Day.new d.strftime("%F"), @mongo
          if day.has_events?
            self << day
          end
          @count += 1
        end
      end

      @descriptor = "%d-day period" % [
        @count
      ]

      @hba1c = @mongo.db.collection("hba1c").find.sort(:timestamp).to_a[-1]
    end

    def average_glucose
      total = 0
      self.each do |d|
        total += d.average_glucose
        puts d.keys
      end

      return total / self.size
    end

    def to_s
      s = "%s commencing %s" % [
        @descriptor,
        @start_date
      ]
      s << "\n"
      s << "\n"

      self.each do |d|
        s << d.minimal
        s << "\n"
      end

      s << "    "
      s << "average glucose for %s commencing %s: %0.2f %s" % [
        @descriptor,
        @start_date,
        self.average_glucose,
        self[0].glucose_units
      ]

      s << "\n"
      s << "    "
      s << "latest hba1c (from %s): %0.1f%s" % [
        @hba1c["date"],
        @hba1c["value"],
        @hba1c["units"]
      ]

      s
    end
  end
end
