module Insulin
# Author::  Sam (mailto:sam@cruft.co)
# License:: MIT

  # This class is a simple wrapper around a YAML config file
  class Config < Hash

    # Open the file at 'path'. If no path is provided, go to default
    def initialize path = nil
      if not path
        path = "conf/insulin.yaml"
      end
      self.update YAML.load File.open path
    end

    # Return a particular section (as a hash)
    def get_section section
      return self[section]
    end
  end
end
