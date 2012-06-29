require 'insulin'

describe Insulin::Event do
  event = Insulin::Event.new Insulin::OnTrackCsvLine.new %q{266,"Jun 28, 2012 10:21:05 AM",Medication,Humalog,After Breakfast,4.0,"F:2 bacon, 2 toast
N:test note
X:fail note
N:other note"}

  it "should have the correct type" do
    event["type"].should == "medication"
  end

  it "should save to mongo" do
    event.save
  end
end
