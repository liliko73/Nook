class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def settings; end
end
