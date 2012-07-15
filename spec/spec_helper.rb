require 'insulin'

@mongo

def load_test_db
  config = Insulin::Config.new 'conf/insulin_dev.yaml'
  mconf = config.get_section "mongo"
  @mongo = Insulin::MongoHandle.new mconf

  csv = Insulin::OnTrack::CsvFile.new "files/on_track.csv"
  csv.save_events @mongo
end

def drop_test_db
  @mongo.drop_db
end

