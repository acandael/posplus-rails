class Publication < ActiveRecord::Base
  include Hideable

  validates :title, :reference, presence: true

  has_many :project_publications
  has_many :research_projects, through: :project_publications
end
