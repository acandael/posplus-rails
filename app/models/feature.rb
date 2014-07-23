class Feature < ActiveRecord::Base
  validates :title, :body, presence: true

  mount_uploader :image, FeatureImageUploader
  mount_uploader :document, FeatureDocumentUploader
end
