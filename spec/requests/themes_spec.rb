require 'rails_helper'

RSpec.describe "Themes", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/themes/show"
      expect(response).to have_http_status(:success)
    end
  end
end
