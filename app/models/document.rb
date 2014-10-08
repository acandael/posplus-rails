class Document < ActiveRecord::Base
  belongs_to :publication
  validates :file, presence: true
  mount_uploader :file, DocumentFileUploader
end
