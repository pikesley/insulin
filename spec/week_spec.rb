require 'insulin'
require "spec_helper.rb"

describe Insulin::Week do
  load_test_db

  w = Insulin::Week.new "2012-06-29", @mongo

  it "should contain something" do
    w.size.should > 0
  end

  it "should have days" do
    w.each do |d|
      d.class.name.should == "Insulin::Day"
    end
  end

  it "should have average glucose" do
    w.average_glucose.should_not == nil
  end

  drop_test_db
end
