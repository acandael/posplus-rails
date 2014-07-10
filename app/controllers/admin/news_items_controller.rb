class Admin::NewsItemsController < ApplicationController
  def index
    @news_items = NewsItem.all
  end

  def show
    @news_item = NewsItem.find(params[:id])
  end

  def new
    @news_item = NewsItem.new
  end

  def edit
    @news_item = NewsItem.find(params[:id])
  end

  def create
    @news_item = NewsItem.create(news_item_params)
    if @news_item.save
      redirect_to admin_news_items_path, notice: "You successfully added a news item"
    else
      flash[:alert] = "There was a problem, the news item could not be added"
      render :new
    end
  end

  def update
    @news_item = NewsItem.find(params[:id])
    if @news_item.update_attributes(news_item_params)
    redirect_to admin_news_items_path, notice: "You successfully updated the news item"
    else
      flash[:alert] = @news_item.errors.full_messages.join(' ')
      render :edit
    end
  end

  def destroy
    news_item = NewsItem.find(params[:id])
    news_item.destroy
    redirect_to admin_news_items_path, notice: "You successfully deleted a news item"
  end

  private

  def news_item_params
    params.required(:news_item).permit(:title, :body, :link)
  end
end
