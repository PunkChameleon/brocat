#!/usr/bin/env ruby -I ../lib -I lib
require "brocat"

User = Class.new
users = [User.new, User.new, User.new]

root { "Hello, API!" }

api do
  version 1 do
    namespace :users do
      collection do
        get { users }
        post do
          users << user = User.new(params[:user])
          user
        end
      end
      member do
        get { users[params[:id]] }
        destroy do
          users.delete_at params[:id]
        end
        put do
          user = users[params[:id]]
          user.name = params[:user][:name]
          user
        end
      end
    end
  end
end
