module Insulin
  class Config < Hash
    def initialize path = nil
      if not path
        path = "conf/insulin.yaml"
      end
      self.update YAML.load File.open path
    end

    def get_section section
      return self[section]
    end
  end
end
