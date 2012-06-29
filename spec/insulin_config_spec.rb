require 'insulin'

describe Insulin::Config do
  config = Insulin::Config.new

  it "should return the correct section" do
    config["mongo"].should == {
      "host"=>"localhost",
      "database"=>"insulin"
    }
  end
end
