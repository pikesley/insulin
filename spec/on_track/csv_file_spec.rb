require 'insulin'

describe Insulin::OnTrackCsvFile do
  csv_file = Insulin::OnTrackCsvFile.new 'files/on_track.csv'

  it "should open the file" do
    csv_file.file.path.should == 'files/on_track.csv'
  end

  it "should create csv lines" do
    csv_file.lines[0].class.name.should == "Insulin::OnTrackCsvLine"
  end

  it "line with serial 342 should have proper noteset" do
    csv_file.lines.each do |c|
      if c["serial"] == 342
        c["notes"].should == {
          "booze"=>[
            "4 pints"
          ],
          "note"=>[
            "new pot of strips"
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

  before :all do
    config = Insulin::Config.new 'conf/insulin_dev.yaml'
    mconf = config.get_section "mongo"
    @mongo = Insulin::MongoHandle.new mconf
  end

  it "should save events" do
    csv_file.save_events @mongo
    @mongo.db.collection("events").count.should >= 40
  end

  it "small-hours event should be assigned to previous-date collection" do
    l = @mongo.db.collection("2012-06-30").find_one( { "serial" => 292 } )
    l.should_not == nil
    l["date"].should == "2012-07-01"
  end

  it "small-hours event should not appear in actual-date collection" do
    l = @mongo.db.collection("2012-06-01").find_one( { "serial" => 292 } )
    l.should == nil
  end

  after :all do
    @mongo.drop_db
  end
end
