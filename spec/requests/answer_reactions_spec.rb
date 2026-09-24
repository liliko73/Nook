require 'rails_helper'

RSpec.describe "AnswerReactions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/answer_reactions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/answer_reactions/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
