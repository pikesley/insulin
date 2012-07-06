#!/bin/bash

. "${HOME}/.rvm/scripts/rvm"

bundle install
bundle exec rspec
