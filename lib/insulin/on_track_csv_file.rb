module Insulin
  class OnTrackCsvFile
    attr_reader :file, :lines, :events

    def initialize csv_path
      @csv_path = csv_path
      @file = File.new @csv_path
      self.read_lines
      self.create_events
    end

    def read_lines
      @lines = []
      l = ""
      while line = @file.gets
        l << line
        if line[-2] == '"'
          o = Insulin::OnTrackCsvLine.new l[0..-2]
          @lines << o
          l = ""
        end
      end

      @lines.sort_by! {|o| o["serial"]}
    end

    def create_events
      @events = []
      @lines.each do |l|
        e = Insulin::Event.new l
        @events << e
      end
    end
  end
end
