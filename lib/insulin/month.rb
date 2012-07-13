require 'insulin'

module Insulin
  class Month < NDayPeriod
    def initialize date, mongo
      super({
        "start_date" => date,
        "days" => 30,
        "mongo" => mongo
      })
    end
  end
end
