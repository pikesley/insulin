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
          self << day
          @count += 1
        end
      end

      @descriptor = "%d-day period" % [
        @count
      ]

    end

    def average_glucose
      total = 0
      self.each do |d|
        total += d.average_glucose
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

      s
    end
  end
end
