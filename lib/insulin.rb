require "insulin/version"
require "insulin/config"
require "insulin/mongo_handle"
require "insulin/event"
require "insulin/day"
require "insulin/week"
require "insulin/on_track/date"
require "insulin/on_track/note"
require "insulin/on_track/note_set"
require "insulin/on_track/csv_line"
require "insulin/on_track/csv_file"

# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

# OnTrack[https://play.google.com/store/apps/details?id=com.gexperts.ontrack&hl=en]
# can export its data as a CSV. Insulin takes this data, parses it into
# (possibly) useful formats, and stuffs it into MongoDB
module Insulin
end
