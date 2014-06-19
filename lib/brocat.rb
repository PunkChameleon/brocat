require "brocat/version"
require "brocat/app"
require "brocat/delegator"

module Brocat
  Application = Class.new App
  at_exit { Rack::Handler::Thin.run Application.new, Port: 1234 }
end

extend Brocat::Delegator
