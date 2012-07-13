require 'insulin'
require "spec_helper.rb"

describe Insulin::Month do
  load_test_db

  m = Insulin::Month.new "2012-06-29", @mongo

  it "should contain something" do
    m.size.should > 0
  end

  it "should have days" do
    m.each do |d|
      d.class.name.should == "Insulin::Day"
    end
  end

  it "should have average glucose" do
    m.average_glucose.should_not == nil
  end

  it "should say '15-day period'" do
    m.to_s.should include "15-day period"
  end

  drop_test_db
end
