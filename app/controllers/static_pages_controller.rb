class StaticPagesController < ApplicationController
  def top
    # ログイン機能実装後は以下のように切り替える：
    # if logged_in?
    #   render :top_logged_in
    # else
    #   render :top_before_login
    # end

    render :top_before_login
  end
end
