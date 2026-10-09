class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :require_no_authentication, only: %i[send_completed edit_completed]
  # GET /resource/password/send_completed
  def send_completed
  end

  # GET /resource/password/edit_completed
  def edit_completed
  end

  protected

  # メール送信後のリダイレクト先
  def after_sending_reset_password_instructions_path_for(resource_name)
    users_password_send_completed_path
  end

  # パスワード変更成功後のリダイレクト先
  def after_resetting_password_path_for(resource)
    users_password_edit_completed_path
  end
end
