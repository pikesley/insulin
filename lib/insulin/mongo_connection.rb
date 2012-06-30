require 'mongo'

module Insulin
  class MongoConnection
    attr_reader :db, :connection

    def initialize conf = nil
      c = Insulin::Config.new conf
      @conf = c.get_section "mongo"

      @connection = Mongo::Connection.new
      @db = @connection.db @conf["database"]
    end

    def drop_db
      @connection.drop_database @conf["database"]
    end
  end
end
