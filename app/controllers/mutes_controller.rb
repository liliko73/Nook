class MutesController < ApplicationController
  before_action :authenticate_user!

  def create
    user_to_mute = User.find(params[:user_id])
    current_user.mute(user_to_mute)
    redirect_back fallback_location: root_path, notice: "#{user_to_mute.username} さんをミュートしました。"
  end

  def destroy
    user_to_unmute = User.find(params[:user_id])
    current_user.unmute(user_to_unmute)
    redirect_back fallback_location: root_path, notice: "#{user_to_unmute.username} さんのミュートを解除しました。"
  end
end
