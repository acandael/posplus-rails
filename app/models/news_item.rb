class NewsItem < ActiveRecord::Base
  include Hideable

  validates :title, :body, presence: true

  mount_uploader :image, NewsItemImageUploader
  mount_uploader :document, NewsItemDocumentUploader

end
