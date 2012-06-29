module Insulin
  class Event < Hash
    def initialize h
      self.update h
    end

    def save
    end
  end
end
