ENV['RACK_ENV']  = 'test'
ENV['RAILS_ENV'] = 'test'

# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test

# Require test libraries
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'mocha/setup'
require 'minitest/reporters'
require 'benchmark'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new, Minitest::Reporters::SpecReporter.new]
Dir.glob('./lib/**/*.rb').each { |file| require file }
