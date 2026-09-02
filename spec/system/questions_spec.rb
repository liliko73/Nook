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
    click_button "投稿する"

    expect(page).to have_content "質問を投稿しました。"
    expect(page).to have_content "離乳食について"
  end

  it "質問一覧に質問が表示されること" do
    question = create(
      :question,
      user: user,
      title: "質問一覧に表示される質問",
      body: "質問本文です"
    )

    visit questions_path

    expect(page).to have_content "質問一覧に表示される質問"
  end

  it "自分の質問を削除できること" do
    question = create(
      :question,
      user: user,
      title: "削除する質問",
      body: "削除する質問の本文です"
    )

    visit question_path(question)

    accept_confirm do
      find('button[title="削除"]').click
    end

    expect(page).not_to have_content "削除する質問"
  end
end
