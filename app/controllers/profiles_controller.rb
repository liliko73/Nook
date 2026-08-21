class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update ]

  def show
    @user = current_user
  end

  def edit
    # 最大4人分までフォームを表示できるよう、足りない分をbuildしておく
    existing_count = @user.children.size
    (4 - existing_count).times { @user.children.build } if existing_count < 4
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "プロフィールを更新しました"
    else
      flash.now[:alert] = "プロフィールの更新に失敗しました"
      # エラーで戻った際にも最大4人分の入力欄を保持する
      existing_count = @user.children.size
      (4 - existing_count).times { @user.children.build } if existing_count < 4
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
      :prefecture,
      children_attributes: [
        :id,
        :birthday_year,
        :birthday_month,
        :birthday_date,
        :gender,
        :_destroy
      ]
    )
  end
end
