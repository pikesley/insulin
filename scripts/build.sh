#!/bin/bash

. "/usr/share/jetty/.rvm/scripts/rvm"

bundle install
bundle exec rspec
