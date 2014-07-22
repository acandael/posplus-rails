class Feature < ActiveRecord::Base
  validates :title, :body, presence: true
end
