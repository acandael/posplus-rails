class Publication < ActiveRecord::Base
  validates :title, :reference, presence: true
end
