class TagsController < ApplicationController
  def show
    @shares = Share.find_tagged_with(params[:id])
  end

end
