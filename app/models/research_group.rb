class ResearchGroup < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :website, :format => URI::regexp(%w(http https))
  mount_uploader :image, ResearchGroupImageUploader
end
