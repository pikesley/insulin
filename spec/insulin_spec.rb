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
