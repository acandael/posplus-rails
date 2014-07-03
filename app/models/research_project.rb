class ResearchProject < ActiveRecord::Base
  validates :title, :body, presence: true
end
