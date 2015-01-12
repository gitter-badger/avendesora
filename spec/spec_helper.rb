# avendesora
#
# Copyright (c) 2015 Eric Will <rakaur@malkier.net>
# Rights to this code are documented in LICENSE.

# These are unit test code coverage tools
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  # Ignore some stuff
  add_filter './bundle/'
  add_filter './spec/'
end
#Coveralls.wear!

# Import the minitest libraries
require 'minitest/autorun'

# Import all of our testing dependencies using Bundler
require 'bundler'
Bundler.require :test

# Make the output of minitest a lot prettier
MiniTest::Reporters.use! [MiniTest::Reporters::SpecReporter.new]

# The tests can start from here...
require_relative '../lib/avendesora'

CONFIG_FILE = File.expand_path('../fixtures/ircd.conf',       __FILE__)
BAD_DAEMON  = File.expand_path('../fixtures/bad-daemon.conf', __FILE__)
BAD_LISTEN  = File.expand_path('../fixtures/bad-listen.conf', __FILE__)
