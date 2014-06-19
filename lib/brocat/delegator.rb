module Brocat
  module Delegator
    def method_missing method, *args, &block
      Application.send method, *args, &block
    end
  end
end
