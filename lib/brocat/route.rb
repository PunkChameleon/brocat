module Brocat
  class Route
    attr_reader :path, :block, :content_type

    def initialize path, opts = {}, &block
      @path = path
      @block = block
      @content_type = opts[:content_type] || "text/html"
    end

  end
end
