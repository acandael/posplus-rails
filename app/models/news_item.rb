class NewsItem < ActiveRecord::Base
  validates :title, :body, presence: true
end
