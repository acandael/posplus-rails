class NewsItem < ActiveRecord::Base
  validates :title, :body, presence: true

  mount_uploader :image, NewsItemImageUploader
  mount_uploader :document, NewsItemDocumentUploader

  def visible?
    visible
  end

  def toggle_visibility!
    if visible?
      update_attribute(:visible, false)
    else
      update_attribute(:visible, true)
    end
  end
end
