module Insulin
  class OnTrackCsvLine < Hash
    def initialize line
      bits = line.split ","
      self["serial"] = bits[0].to_i
      self.update OnTrackDate.new "%s%s" % [
        bits[1],
        bits[2]
      ]
      self["type"] = bits[3].downcase
      self["subtype"] = bits[4].downcase if not bits[4] == ""
      self["tag"] = bits[5].downcase
      self["value"] = bits[6].to_f
    end
  end
end
