require 'rails_helper'

RSpec.describe "Answers", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:question) { create(:question, user: other_user) }
  let!(:own_question) { create(:question, user: user) }

  before do

    visit new_user_session_path

    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password123"
    click_button "ログイン"
  end

  it "他人の質問に回答を投稿できること" do
    visit question_path(question)

    fill_in "answer[body]", with: "我が家ではこうしています！"
    click_button "回答を投稿する"

    expect(page).to have_content "我が家ではこうしています！"
  end

  it "自分の質問には回答できないこと" do
    visit question_path(own_question)

    expect(page).not_to have_field "answer[body]"
  end
end
