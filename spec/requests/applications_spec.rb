require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "GET /landing" do
    it "returns http success" do
      get "/applications/landing"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/applications/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/applications/create"
      expect(response).to have_http_status(:success)
    end
  end

end
