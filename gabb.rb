#!/usr/bin/env ruby
require 'bundler'
Bundler.require


Dir["./lib/gabb/*.rb"].each {|file| require file }
Dir["./lib/exercises/*.rb"].each {|file| require file }

GABB::Manager.new
