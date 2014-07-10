class NewsItemsController < ApplicationController

  def show
    @news_item = NewsItem.find(params[:id])
  end
end
