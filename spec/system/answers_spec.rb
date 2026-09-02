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

  it "回答に返信を投稿できること" do
    answer = create(
      :answer,
      user: user,
      question: question,
      parent_id: nil,
      body: "親回答です"
    )

    visit question_path(question)

    within("#answer-#{answer.id}") do
      fill_in "answer[body]", with: "回答への返信です"
      click_button "返信"
    end

    expect(page).to have_content "回答への返信です"
  end

  it "自分の回答を削除できること" do
    answer = create(
      :answer,
      user: user,
      question: question,
      parent_id: nil,
      body: "削除する回答です"
    )

    visit question_path(question)

    within("#answer-#{answer.id}") do
      accept_confirm do
        find('button[title="削除"]').click
      end
    end

    expect(page).not_to have_content "削除する回答です"
  end
end
