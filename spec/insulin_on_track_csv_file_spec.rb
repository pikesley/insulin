require 'insulin'

describe Insulin::OnTrackCsvFile do
  csv_file = Insulin::OnTrackCsvFile.new 'files/on_track.csv'

  it "should open the file" do
    csv_file.file.path.should == 'files/on_track.csv'
  end

  it "should create csv lines" do
    csv_file.lines[0].class.name.should == "Insulin::OnTrackCsvLine"
  end

  it "line with serial 266 should have proper noteset" do
    csv_file.lines.each do |c|
      if c["serial"] == 266
        c["notes"].should == {
          "food"=>[
            "2 bacon",
            "2 toast"
          ],
          "note"=>[
            "test note"
          ]
        }
      end
    end
  end

  it "lines should be sorted by serial" do
    error = false
    last_serial = 0
    csv_file.lines.each do |l|
      if not l["serial"] > last_serial
        error = true
      end
      last_serial = l["serial"]
    end
    error.should_not == true
  end

  it "should create events" do
    csv_file.events[0].class.name.should == "Insulin::Event"
  end

  mongo = Insulin::MongoHandle.new 'conf/insulin_dev.yaml'

  it "should save events" do
    csv_file.save_events mongo
    mongo.db.collection("events").count.should > 200
  end

  mongo.drop_db
end
