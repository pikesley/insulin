require 'insulin'

describe Insulin::MongoHandle do
  handle = Insulin::MongoHandle.new 'conf/insulin_dev.yaml'
  conf = Insulin::Config.new 'conf/insulin_dev.yaml'
  mconf = conf.get_section "mongo"

  it "should make a connection to mongo" do
    handle.connection.database_names.size.should >= 1
  end

  it "should have a database" do
    handle.db.name.should == mconf["database"]
  end

  it "should drop the database" do
    handle.drop_db
    handle.connection.database_names.include?(mconf["database"]).should_not == true
  end
end
