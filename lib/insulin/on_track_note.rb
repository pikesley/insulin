module Insulin
  class OnTrackNote
    @@keys = {
      "F" => "food",
      "B" => "booze",
      "N" => "note"
    }

    attr_reader :type, :content
    def initialize n
      bits = n.split ":"
      t = bits[0].strip
      if @@keys.keys.include? t
        @content = bits[1].strip.downcase
        if ["F", "B"].include? t
          a = []
          @content.split(",").each do |v|
            a << v.strip
          end
          @content = a
        end
        @type = @@keys[t]
      end
    end
  end
end
