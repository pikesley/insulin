require 'insulin'
require "spec_helper.rb"

describe Insulin::Day do
  load_test_db

  d = Insulin::Day.new "2012-06-30", @mongo

  it "should contain something" do
    d.keys.size.should > 0
  end

  it "should have events" do
    d.keys.each do |k|
      d[k].each do |e|
        e.class.name.should == "Insulin::Event"
      end
    end
  end

  it "should have glucose events" do
    d["glucose"].each do |g|
      g["type"].should == "glucose"
    end
  end

  it "should have at most 1 lantus event" do
    d["lantus"].size.should < 2
  end

  it "should display correctly" do
    d.to_s.should include "19:07:42 BST | dinner       | medication | humalog    |  6.0 x10^-5 L"
  end

  it "minimal display should be correct" do
    d.minimal.should_not include "exercise"
  end

  puts d

  drop_test_db
end
