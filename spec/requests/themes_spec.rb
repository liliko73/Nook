require 'rails_helper'

RSpec.describe "Themes", type: :request do
  let(:user) { create(:user) }
  let(:theme) { create(:theme) }

  before do
    sign_in user # Deviseのテストヘルパーでログイン
  end

  describe "GET /show" do
    it "returns http success" do
      get theme_path(theme)
      expect(response).to have_http_status(:success)
    end
  end
end
