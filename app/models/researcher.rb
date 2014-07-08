class Researcher < ActiveRecord::Base
  validates :name, presence: :true, uniqueness: :true
  validates :bio, presence: :true
end
