require 'insulin'

describe Insulin::OnTrackNoteSet do
  simple_note_set = Insulin::OnTrackNoteSet.new "F: turkey breast, salad"

  it "should have the correct notes" do
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

  it "should have the correct notes" do
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

  it "should have the correct notes" do
    failing_note_set.should == {
      "food" => [
        "turkey breast",
        "salad"
      ]
    }
  end
end
