require 'insulin'

describe Insulin::MongoConnection do
  cnxn = Insulin::MongoConnection.new

  it "should make a connection to mongo" do
    cnxn.connection.database_names.size.should >= 1
  end

  it "should have a database" do
    cnxn.db.name.should == "insulin"
  end
end
