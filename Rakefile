#!/usr/bin/env rake

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "bundler/gem_tasks"
require "insulin/version"
 
task :build do
  system "gem build insulin.gemspec"
  system "mv insulin*gem pkg/"
end
 
task :release => :build do
  system "gem push pkg/insulin-#{Insulin::VERSION}"
end

task :rspec do
  system "bundle exec rspec"
end
