require "spec_helper"
require "brocat/app"

module Brocat
  describe App do
    describe "Basic app" do
      class TestApp < described_class
        root { "Hello, World!" }
      end

      it "responds to .call" do
        expect(described_class.new).to respond_to :call
      end

      it "responds to an HTTP request at /" do
        request = ::Rack::MockRequest.new TestApp.new
        response = request.get "/"
        expect(response).to be_ok
        expect(response.body).to eq "Hello, World!"
        expect(response.content_type).to eq "text/html"
      end
    end

    describe "Member" do
      class TestMemberApp < described_class
        namespace(:users) { member { get { "User record" } } }
      end

      before do
        @request = ::Rack::MockRequest.new TestMemberApp.new
        @response = @request.get "/users/1"
      end

      pending "maps a request with variable id" do
        expect(@response).to be_ok
      end
    end

    describe "API" do
      class TestApiApp < described_class
        api { get(:users) { "Hey, API users" } }
      end

      before do
        @request = ::Rack::MockRequest.new TestApiApp.new
        @response = @request.get "/api/users"
      end


      it "registers routes at the /api namespace" do
        expect(@response).to be_ok
        expect(@response.body).to eq "Hey, API users"
      end

      it "returns JSON" do
        expect(@response.content_type).to eq "application/json"
      end
    end

    describe "Namespaces routes" do
      class TestNamespaceApp < described_class
        namespace :admin do
          get(:users) { "Hello, Users!" }
          namespace(:superadmin) { get(:users) { "Hello, SuperAdmin!" } }
        end
      end

      before do
        @request = ::Rack::MockRequest.new TestNamespaceApp.new
      end

      it "maps namespaced routes" do
        response = @request.get "/admin/users"
        expect(response).to be_ok
        expect(response.body).to eq "Hello, Users!"
      end

      it "can handle nested namespace routes" do
        response = @request.get "/admin/superadmin/users"
        expect(response).to be_ok
        expect(response.body).to eq "Hello, SuperAdmin!"
      end
    end
  end
end
