require 'rails_helper'

RSpec.describe "Questions", type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  it "新規質問を作成できること" do
    visit new_question_path

    fill_in "question[title]", with: "離乳食について"
    fill_in "question[body]", with: "おすすめの離乳食レシピを教えてください。"
    click_button "投稿" # ※実際のボタン名に変更してください

    expect(page).to have_content "質問を投稿しました。"
    expect(page).to have_content "離乳食について"
  end
end
