require 'insulin'
require 'spec_helper.rb'

describe Insulin::Pdf do
  config = Insulin::Config.new "conf/insulin_dev.yaml"
  o = config.get_section "outputs"

  load_test_db

  p = Insulin::Pdf.new Insulin::Week.new("2012-06-29", @mongo), o["pdf_file"]

  it "should generate a pdf" do
    p.render
    File.should exist o["pdf_file"]
  end

  drop_test_db
end
