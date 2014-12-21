#!/usr/bin/env ruby
require 'bundler'
Bundler.require


Dir["./lib/gabb/*.rb"].each {|file| require file }
Dir["./lib/gabb/exercise/*.rb"].each {|file| require file }
Dir["./lib/exercises/**/exercise.rb"].each {|file| require file }

GABB::Program.new
