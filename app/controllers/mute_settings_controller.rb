class MuteSettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    # ログインユーザーがミュートしているユーザー一覧を取得
    @muted_users = current_user.muting_users.order("mutes.created_at DESC")
  end
end
