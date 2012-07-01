require 'mongo'

module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  # This class is a simple wrapper around a MongoDB connection
  class MongoHandle
    attr_reader :db, :connection

    # Set up the connection as described by 'conf'
    def initialize conf = nil

      # Config has a sensible default file
      c = Insulin::Config.new conf
      @conf = c.get_section "mongo"

      @connection = Mongo::Connection.new
      @db = @connection.db @conf["database"]
    end

    # Drop this database
    def drop_db
      @connection.drop_database @conf["database"]
    end
  end
end
