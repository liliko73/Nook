class ThemesController < ApplicationController
  def show
    @theme = Theme.find(params[:id])
    @comments = []
  end
end
