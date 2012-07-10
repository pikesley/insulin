require 'insulin'

describe Insulin::OnTrack::Note do
  note = Insulin::OnTrack::Note.new "N:After wine. No overnight hypo."

  it "should have the correct note" do
    note.type.should == "note"
    note.content.should == "after wine. no overnight hypo."
  end

  list_note = Insulin::OnTrack::Note.new "F: turkey breast, salad"

  it "should have the correct list-type note" do
    list_note.type.should == "food"
    list_note.content.should == ["turkey breast", "salad"]
  end

  fail_note = Insulin::OnTrack::Note.new "X: this one should fail"

  it "should handle the fail note correctly" do
    fail_note.type.should == nil
    fail_note.content.should == nil
  end
end
