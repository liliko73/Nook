class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :top ]

  def top
    if user_signed_in?
      # 最新のテーマを1件取得（シードデータ等の最初のデータ）
      @theme = Theme.first
      # ログイン済みの場合は top_logged_in.html.erb を表示
      render :top_logged_in
    else
      # 未ログインの場合は top_before_login.html.erb を表示
      render :top_before_login
    end
  end
end
