class Document < ActiveRecord::Base
  belongs_to :publication
  mount_uploader :file, DocumentFileUploader
end
