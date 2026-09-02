require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let!(:user) { create(:user) }
  let!(:theme) { create(:theme) }

  before do
    sign_in user
  end

  it "テーマ詳細ページからコメントを投稿できること" do
    visit theme_path(theme)

    fill_in "comment[body]", with: "テストコメントです"
    click_button "コメントする"

    expect(page).to have_content "コメントを投稿しました。"
    expect(page).to have_content "テストコメントです"
  end

  it "コメントに返信を投稿できること" do
    comment = create(
      :comment,
      user: user,
      theme: theme,
      parent_id: nil,
      body: "親コメントです"
    )

    visit theme_path(theme)

    within("#comment_#{comment.id}") do
      find("summary").click
      fill_in "comment[body]", with: "返信コメントです"
      click_button "返信する"
    end

    within("#comment_#{comment.id}") do
      find("summary").click
    end

    expect(page).to have_content "返信コメントです"
  end

  it "自分のコメントを削除できること" do
    comment = create(
      :comment,
      user: user,
      theme: theme,
      parent_id: nil,
      body: "削除するコメントです"
    )

    visit theme_path(theme)

    within("#comment_#{comment.id}") do
      accept_confirm do
        find("form[action='#{theme_comment_path(theme, comment)}'] button").click
      end
    end

    expect(page).not_to have_content "削除するコメントです"
  end
end
