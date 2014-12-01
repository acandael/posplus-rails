class Document < ActiveRecord::Base
  belongs_to :publication

  scope :by_publication, ->(publication_id){ where(publication_id: publication_id) }
  validates :file, presence: true
  mount_uploader :file, DocumentFileUploader
end
