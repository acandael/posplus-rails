class NewsItem < ActiveRecord::Base
  include Hideable

  scope :by_created_at, ->{ order(created_at: :desc) }

  validates :title, :body, presence: true
  validates :image, format: { :with => /\.(png|gif|jpg|jpeg)\z/i },
                      allow_blank: true
  validate :image_size

  mount_uploader :image, NewsItemImageUploader
  mount_uploader :document, NewsItemDocumentUploader


  private

  def image_size
    if image.size > 3.megabytes
      errors.add(:image, "should be less than 3MB")
    end
  end

end
