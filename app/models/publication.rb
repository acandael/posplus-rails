class Publication < ActiveRecord::Base
  validates :title, :reference, presence: true

  belongs_to :research_project
end
