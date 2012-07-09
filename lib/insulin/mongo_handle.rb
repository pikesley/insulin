require 'mongo'

module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  # This class is a simple wrapper around a MongoDB connection
  class MongoHandle
    attr_reader :db, :connection

    # Set up the connection as described by 'conf'
    def initialize conf
      @conf = conf
      begin
        @connection = Mongo::Connection.new 
        @db = @connection.db @conf["database"]
      rescue Mongo::ConnectionFailure
        puts "MongoDB doesn't appear to be running. We can't go on without this"
        exit 1
      end
    end

    # Drop this database
    def drop_db
      @connection.drop_database @conf["database"]
    end
  end
end
