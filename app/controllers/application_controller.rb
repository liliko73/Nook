class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def configure_permitted_parameters
    # ユーザー登録（sign_up）時に許可するパラメーター
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :username,
      :self_introduction,
      :birthday_year,
      :birthday_month,
      :birthday_date,
      :gender,
      :prefecture,
      children_attributes: [ :id, :birthday_year, :birthday_month, :birthday_date, :gender, :_destroy ]
    ])

    # アカウント更新時にも許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :username,
      :self_introduction,
      :birthday_year,
      :birthday_month,
      :birthday_date,
      :gender,
      :prefecture,
      children_attributes: [ :id, :birthday_year, :birthday_month, :birthday_date, :gender, :_destroy ]
    ])
  end
end
