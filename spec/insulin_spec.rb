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
    otd["day"].should == "friday"
  end

  otd_gmt = Insulin::OnTrackDate.new "Jan 22 2012 9:00:12 PM"

  it "get timestamp" do
    otd_gmt["timestamp"].to_s.should == "2012-01-22 21:00:12 +0000"
  end

  it "get time" do
    otd_gmt["time"].should == "21:00:12 GMT"
  end
end

describe Insulin::OnTrackNote do
  note = Insulin::OnTrackNote.new "N:After wine. No overnight hypo."

  it "get note" do
    note.type.should == "note"
    note.content.should == "after wine. no overnight hypo."
  end

  list_note = Insulin::OnTrackNote.new "F: turkey breast, salad"

  it "get list-type note" do
    list_note.type.should == "food"
    list_note.content.should == ["turkey breast", "salad"]
  end

  fail_note = Insulin::OnTrackNote.new "X: this one should fail"

  it "get fail note" do
    fail_note.type.should == nil
    fail_note.content.should == nil
  end
end

describe Insulin::OnTrackNoteSet do
  simple_note_set = Insulin::OnTrackNoteSet.new "F: turkey breast, salad"

  it "get simple note set" do
    simple_note_set.should == {
      "food" => [
        "turkey breast",
        "salad"
      ]
    }
  end

  multiple_note_set = Insulin::OnTrackNoteSet.new "F: turkey breast, salad
    N:After wine. No overnight hypo.
    N:some other note
    B: glass of wine"

  it "get multiple note set" do
    multiple_note_set.should == {
      "food" => [
        "turkey breast",
        "salad"
      ],
      "note" => [
        "after wine. no overnight hypo.",
        "some other note"
      ],
      "booze" => [
        "glass of wine"
      ]
    }
  end

  failing_note_set = Insulin::OnTrackNoteSet.new "F: turkey breast, salad
X:This should fail"

  it "get failing note set" do
    failing_note_set.should == {
      "food" => [
        "turkey breast",
        "salad"
      ]
    }
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

  csv_with_note = Insulin::OnTrackCsvLine.new %q{266,"Jun 28, 2012 10:21:05 AM",Medication,Humalog,After Breakfast,4.0,"F:2 bacon, 2 toast
N:test note
X:fail note
N:other note"}

  it "get subtype" do
    csv_with_note["subtype"].should == "humalog"
  end

  it "get day" do
    csv_with_note["day"].should == "thursday"
  end

  it "get unixtime" do
    csv_with_note["unixtime"].should == 1340875265
  end

  it "get notes" do
    csv_with_note["notes"].should == {
      "food" => [
        "2 bacon",
        "2 toast"
      ],
      "note" => [
        "test note",
        "other note"
      ]
    }
  end
end
