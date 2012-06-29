module Insulin
  class OnTrackNoteSet < Hash
    def initialize s
      l = s.split"\n"
      l.each do |n|
        x = OnTrackNote.new n
        if x.type
          if not self[x.type]
            if x.content.class.name == "Array"
              self[x.type] = x.content
            else
              self[x.type] = [x.content]
            end
          else
            self[x.type] << x.content
          end
        end
      end
    end
  end
end
