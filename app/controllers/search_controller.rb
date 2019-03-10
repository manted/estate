class SearchController < ApplicationController
  def index
    @projects = []
  end

  def search
    lot = params[:lot]
    @projects = Project.where(lot: lot)

    # render 'search'
  end
end