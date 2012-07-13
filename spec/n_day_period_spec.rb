require 'insulin'
require 'spec_helper.rb'

describe Insulin::NDayPeriod do
  load_test_db

  b = Insulin::NDayPeriod.new({
    "start_date" => "2012-06-29",
    "days" => 3,
    "mongo" => @mongo
  })

  it "should contain 3 items" do
    b.size.should == 3
  end

  it "items should be days" do
    b.each do |d|
      d.class.name.should == "Insulin::Day"
    end
  end

  it "should have average glucose of 7.16" do
    ("%0.2f" % b.average_glucose).to_f.should == 7.16
  end

  c = Insulin::NDayPeriod.new(
    "start_date" => Time.new.strftime("%F"),
    "days" => 7,
    "mongo" => @mongo
  )

  it "should not go storming off into the future" do
    c.size.should == 1
  end

  t = Time.new
  t = t + 86400
  d = Insulin::NDayPeriod.new(
    "start_date" => t.strftime("%F"),
    "days" => 7,
    "mongo" => @mongo
  )

  it "should have nothing if start_date is in the future" do
    d.size.should == 0
  end

  drop_test_db

end
