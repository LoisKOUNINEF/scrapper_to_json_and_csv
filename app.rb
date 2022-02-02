require 'bundler'
Bundler.require

$:.unshift File.expand_path('../lib', __FILE__)

require 'app/scrapper'

Scrapper.new.perform

json = File.read("db/emails.json")
obj = JSON.parse(json)

pp obj

