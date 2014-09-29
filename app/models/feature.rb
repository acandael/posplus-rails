class Feature < ActiveRecord::Base
  validates :title, :body, presence: true
  validates :image, format: { :with => /\.(png|gif|jpg|jpeg)\z/i },
                      allow_blank: true
  validate :image_size

  mount_uploader :image, FeatureImageUploader
  mount_uploader :document, FeatureDocumentUploader


  private

  def image_size
    if image.size > 3.megabytes
      errors.add(:image, "should be less than 3MB")
    end
  end
end
