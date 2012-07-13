require 'insulin'
require 'time'

module Insulin
  class NDayPeriod < Array
    def initialize hash
      @start_date = hash["start_date"]
      @days = hash["days"]
      @mongo = hash["mongo"]

      @descriptor = "%d-day period"

      t = Time.parse @start_date
      today = Time.new
      @days.times do |i|
        d = (t + (i * 86400))
        if d <= today
          day = Day.new d.strftime("%F"), @mongo
          self << day
        end
      end
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
      s << "Average glucose for %s commencing %s: %0.2f" % [
        @descriptor,
        @start_date,
        self.average_glucose
      ] 

      s
    end
  end
end
