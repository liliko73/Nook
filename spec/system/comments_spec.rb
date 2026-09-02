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
end
