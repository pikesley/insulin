require 'insulin'

describe Insulin::Event do
  event = Insulin::Event.new Insulin::OnTrackCsvLine.new %q{266,"Jun 28, 2012 10:21:05 AM",Medication,Humalog,After Breakfast,4.0,"F:2 bacon, 2 toast
N:test note
X:fail note
N:other note"}

  it "should have the correct type" do
    event["type"].should == "medication"
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
  end

  mongo.drop_db
end
