require 'bundler'
Bundler.require

$:.unshift File.expand_path('../lib', __FILE__)

require 'app/scrapper'

Scrapper.new.perform

json = File.read("db/emails.json")
obj1 = JSON.parse(json)
csv = File.read("db/emails.csv")
obj2 = CSV.parse(csv)
pp obj1
pp obj2

