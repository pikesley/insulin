require 'insulin'

describe Insulin::OnTrackDate do
  otd = Insulin::OnTrackDate.new "Jun 22 2012 9:00:12 AM"

  it "get timestamp" do
    otd["timestamp"].to_s.should == "2012-06-22 09:00:12 +0100"
  end

  it "get time" do
    otd["time"].should == "09:00:12 BST"
  end

  it "get date" do
    otd["date"].should == "2012-06-22"
  end

  it "get day" do
    otd["day"].should == "Friday"
  end
end

describe Insulin::OnTrackNote do
  note = Insulin::OnTrackNote.new "N:After wine. No overnight hypo."

  it "get note" do
    note.should == {"note" => "after wine. no overnight hypo."}
  end
end

describe Insulin::OnTrackNote do
  note = Insulin::OnTrackNote.new "F: turkey breast, salad"

  it "get list-type note" do
    note.should == {"food" => ["turkey breast", "salad"]}
  end
end

describe Insulin::OnTrackCsvLine do
  csv = Insulin::OnTrackCsvLine.new %q{199,"Jun 22, 2012 8:01:39 AM",Glucose,,Breakfast,5.7,""} 

  it "get serial" do
    csv["serial"].should == 199
  end

  it "get time" do
    csv["time"].should == "08:01:39 BST"
  end

  it "get date" do
    csv["date"].should == "2012-06-22"
  end

  it "get type" do
    csv["type"].should == "glucose"
  end

  it "get subtype" do
    csv["subtype"].should == nil
  end

  it "get tag" do
    csv["tag"].should == "breakfast"
  end

  it "get value" do
    csv["value"].should == 5.7
  end

  it "get notes" do
    csv["notes"].should == nil
  end
end
