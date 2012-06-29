require 'insulin'

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
