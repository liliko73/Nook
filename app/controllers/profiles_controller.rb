class ProfilesController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "プロフィールを更新しました"
    else
      flash.now[:alert] = "プロフィールの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :username,
      :self_introduction,
      :birthday_year,
      :birthday_month,
      :birthday_date,
      :gender,
      :prefecture
    )
  end
end
