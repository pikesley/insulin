require 'insulin'

describe Insulin::OnTrackDate do
  otd = Insulin::OnTrackDate.new "Jun 22 2012 9:00:12 AM"

  it "should have the correct timestamp" do
    otd["timestamp"].to_s.should == "2012-06-22 09:00:12 +0100"
  end

  it "should have the correct time" do
    otd["time"].should == "09:00:12 BST"
  end

  it "should have the correct date" do
    otd["date"].should == "2012-06-22"
  end

  it "should have the correct day" do
    otd["day"].should == "friday"
  end

  otd_gmt = Insulin::OnTrackDate.new "Jan 22 2012 9:00:12 PM"

  it "should have the correct timestamp" do
    otd_gmt["timestamp"].to_s.should == "2012-01-22 21:00:12 +0000"
  end

  it "should have the correct time and TZ" do
    otd_gmt["time"].should == "21:00:12 GMT"
  end
end
