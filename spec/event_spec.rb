require 'insulin'

describe Insulin::Event do
  event = Insulin::Event.new Insulin::OnTrack::CsvLine.new %q{266,"Jun 28, 2012 10:21:05 AM",Medication,Humalog,After Breakfast,4.0,"F:2 bacon, 2 toast
N:test note
X:fail note
N:other note"}

  it "should have the correct type" do
    event["type"].should == "medication"
  end

  it "should have the correct units" do
    event["units"].should == "x10^-5 L"
  end

  conf = Insulin::Config.new 'conf/insulin_dev.yaml'
  mconf = conf.get_section "mongo"
  mongo = Insulin::MongoHandle.new mconf

  event.save mongo
  clxns = [
    "events",
    event["type"],
    event["subtype"],
    event["date"]
  ]

  clxns.each do |c|
    item = mongo.db.collection(c).find_one(
      {"serial" => 266}
    )

    it "should save to the '%s' collection" % c do
      item.should_not == nil
    end

    it "saved event should have correct type" do
      item["type"].should == "medication"
    end

    it "saved event should have correct tag" do
      item["tag"].should == "after breakfast"
    end

    it "saved event should have correct value" do
      item["value"].should == 4.0
    end

    it "saved event should have correct units" do
      item["units"].should == "x10^-5 L"
    end
  end

  mongo_event = Insulin::Event.new mongo.db.collection("events").find_one(
    {"serial" => 266}
  )

  it "loaded event should have correct date" do
    mongo_event["date"].should == "2012-06-28"
  end

  it "loaded event should have correct time" do
    mongo_event["time"].should == "10:21:05 BST"
  end

  bp_event = Insulin::Event.new Insulin::OnTrack::CsvLine.new %q{440,"Jun 30, 2012 3:46:15 PM",Blood Pressure,,After Lunch,118/75,""}

  it "should have the correct value" do
    bp_event["value"].should == "118/75"
  end

  mongo.drop_db
end
