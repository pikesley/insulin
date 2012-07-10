require 'insulin'
require 'time'

module Insulin
  class Week < Array
    def initialize date, mongo
      @date = date
      @mongo = mongo

      t = Time.parse @date
      6.times do |i|
        d = (t + (i * 86400)).strftime "%F"
        day = Day.new d, @mongo
        self << day
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
      s = "Week commencing %s" % @date
      s << "\n"
      s << "\n"

      self.each do |d|
        s << d.minimal
        s << "\n"
      end

      s << "    "
      s << "Average glucose for week commencing %s: %4.1f" % [
        @date,
        self.average_glucose
      ]
      s
    end
  end
end
