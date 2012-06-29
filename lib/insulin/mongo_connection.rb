require 'mongo'

module Insulin
  class MongoConnection
    attr_reader :db, :connection

    def initialize
      c = Insulin::Config.new
      @conf = c.get_section "mongo"

      @connection = Mongo::Connection.new
      @db = @connection.db @conf["database"]
    end
  end
end
