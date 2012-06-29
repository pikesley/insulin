module Insulin
  class OnTrackNote
    config = Insulin::Config.new
    @@keys = config.get_section "note_keys"

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
