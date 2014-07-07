class Researcher < ActiveRecord::Base
  validates :name, :bio, presence: :true
end
