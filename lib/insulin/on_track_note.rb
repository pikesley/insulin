module Insulin

  class OnTrackNote < Hash
    @@keys = {
      "F" => "food",
      "B" => "booze",
      "N" => "note"
    }
    def initialize n
      bits = n.split ":"
      k = bits[0]
      value = bits[1].strip.downcase
      if ["F", "B"].include? k
        a = []
        value.split(",").each do |v|
          a << v.strip
        end
        value = a
      end
      self[@@keys[k]] = value
    end
  end
end
