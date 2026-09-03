class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    # マイページトップ画面を表示するのみ
  end
end
