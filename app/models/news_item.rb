class NewsItem < ActiveRecord::Base
  validates :title, :body, presence: true

  mount_uploader :image, NewsItemImageUploader
  mount_uploader :document, NewsItemDocumentUploader
end
