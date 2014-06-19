#!/usr/bin/env ruby -I ../lib -I lib
require "brocat"

User = Class.new
users = [User.new, User.new, User.new]

root { "Hello, API!" }

api do
  get(:wat) { "Wat" }
end
