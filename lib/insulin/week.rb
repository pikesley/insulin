require 'insulin'

module Insulin
  class Week < NDayPeriod
    def initialize date, mongo
      super({
        "start_date" => date,
        "days" => 7,
        "mongo" => mongo
      })

      @descriptor = "week"      
    end
  end
end
