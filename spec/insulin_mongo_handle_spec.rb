require 'insulin'

describe Insulin::MongoHandle do
  conf = Insulin::Config.new 'conf/insulin_dev.yaml'
  mconf = conf.get_section "mongo"

  handle = Insulin::MongoHandle.new mconf

  it "should make a connection to mongo" do
    handle.connection.database_names.size.should >= 1
  end

  it "should have a database" do
    handle.db.name.should == mconf["database"]
  end

  it "should drop the database" do
    handle.drop_db
    handle.connection.database_names.include?(mconf["database"]).should_not ==
      true
  end

  it "should respond correctly to being passed a hash" do
    prod_handle = Insulin::MongoHandle.new(
      {
        "database" => "prawn"
      }
    )
    prod_handle.db.name.should == "prawn"
    prod_handle.drop_db
  end
end
