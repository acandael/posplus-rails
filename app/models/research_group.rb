class ResearchGroup < ActiveRecord::Base

  scope :by_name, ->{ order(created_at: :desc) }
  validates :name, presence: true, uniqueness: true
  validates :website, :format => URI::regexp(%w(http https))

  mount_uploader :image, ResearchGroupImageUploader
end
