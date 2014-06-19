module Brocat
  class Namespace
    VERBS = [:get, :post, :put, :delete]

    attr_reader :routes, :name, :content_type

    VERBS.each do |verb|
      define_method verb do |path, opts = {}, &blk|
        route verb.upcase, path, opts, &blk
      end
    end

    def initialize name = "", opts = {}, &block
      @name = name
      @routes = {}
      @content_type = opts[:content_type] || @content_type
      instance_eval(&block) if block_given?
      self
    end

    def namespace child, opts = {}, &blk
      add_routes! self.class.new([name, child].join("/"), opts, &blk)
    end

    def member opts = {}, &blk
      add_routes! Member.new(name, opts, &blk)
    end

    private

    def add_routes! obj
      @routes.merge!(obj.routes) { |verb, p1, p2| @routes[verb].merge(p2) }
      obj
    end

    def route verb, path, opts = {}, &block
      full_path = generate_path path
      opts[:content_type] ||= content_type
      routes[verb] ||= {}
      routes[verb][full_path] = Route.new full_path, opts, &block
    end

    def generate_path path
      path = [name, path].reject(&:empty?).join("/")
      path.insert(0 , "/") if path[0] != "/"
      path
    end
  end

  class Member < Namespace
    VERBS.each do |verb|
      define_method verb do |opts = {}, &blk|
        route verb.upcase, ":id", opts, &blk
      end
    end
  end

end
