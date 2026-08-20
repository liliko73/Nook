require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { create(:user) } # FactoryBotでテスト用ユーザーを作成

  before do
    # Deviseのヘルパーでログイン状態にする
    sign_in user
  end

  describe "GET /profile" do
    it "returns http success" do
      get profile_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /profile/edit" do
    it "returns http success" do
      get edit_profile_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /profile" do
    it "updates the profile and redirects" do
      patch profile_path, params: { user: { username: "新しい名前" } }
      # 更新後は詳細画面（またはマイページ）へリダイレクトされるか、200 OKが返るか仕様に合わせて検証
      expect(response).to have_http_status(:redirect)
    end
  end
end
