# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super do |resource|
      # 新規登録画面を開いた時に、最初から1人分のお子様入力欄を置く
      resource.children.build if resource.children.empty?
    end
  end

  # 新規登録の確認画面 (POST /users/sign_up/confirm)
  def new_confirm
    # 入力されたパラメータを使って一時的なUserオブジェクト（とChildオブジェクト）を作成
    self.resource = build_resource(sign_up_params)

    # 入力チェック（バリデーション）
    if resource.invalid?
      # エラーがあれば入力画面に戻す
      render :new, status: :unprocessable_entity
    end
    # バリデーションOKなら new_confirm.html.erb を表示
  end

  # 仮登録完了処理・メール送信 (POST /users/sign_up)
  def create
    # 確認画面で「戻る」ボタンが押された場合の処理
    if params[:back].present?
      self.resource = build_resource(sign_up_params)
      
      # もし何らかの理由でお子様が空になっている場合は最低1人分を担保
      resource.children.build if resource.children.empty?
      
      # 入力画面に戻す（※ status: :unprocessable_entity または :ok）
      render :new, status: :ok
      return    
    end

    # 入力パラメータからUser（およびChild）オブジェクトを作成
    self.resource = build_resource(sign_up_params)

    # データベースへ保存（Deviseの標準保存処理）
    resource.save
    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        # 仮登録メール送信（メール認証機能を使用している場合）のメッセージ
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      # 保存に失敗した場合（何らかのエラー）
      clean_up_passwords resource
      set_minimum_password_length
      render :new_confirm, status: :unprocessable_entity
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # Deviseで許可するパラメータ（ストロングパラメータ）の設定
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :username, :self_introduction,
      :birthday_year, :birthday_month, :birthday_date,
      :gender, :prefecture,
      children_attributes: [:id, :birthday_year, :birthday_month, :birthday_date, :gender, :_destroy]
    ])
  end

  # 仮登録完了（メール送信後）の遷移先を指定
  def after_inactive_sign_up_path_for(resource)
    # new_complete に対応するルーティングのパスを指定します
    # 例: users_sign_up_complete_path や new_user_registration_complete_path など
    users_sign_up_complete_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
