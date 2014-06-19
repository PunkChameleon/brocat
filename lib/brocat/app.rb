require "rack"
require "brocat/route"
require "brocat/namespace"

module Brocat
  class App
    class << self
      attr_reader :root_namespace

      def routes
        root_namespace.routes
      end

      def reset!
        @root_namespace = Namespace.new
        self
      end

      def inherited(child) child.reset!; super end

      def root(opts = {}, &blk)
        @root_namespace.get "/", opts, &blk
      end

      def api(opts = {}, &blk)
        opts[:content_type] ||= "application/json"
        namespace :api, opts, &blk
      end

      [:namespace, :get, :put, :post, :delete].each do |meth|
        define_method meth do |*args, &blk|
          @root_namespace.send meth, *args, &blk
        end
      end
    end

    attr_accessor :env, :request, :response

    def call env
      @env = env
      @request = ::Rack::Request.new env
      @response = route!
    end

    private

    def route!
      verb = request.request_method.to_sym
      path = request.path_info
      route = self.class.routes[verb][path]
      res = route ? instance_eval(&route.block) : nil
      res ? ::Rack::Response.new(res, 200, {
        "Content-Type" => route.content_type
      }) : not_found
    end

    def not_found
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end

  end
end
