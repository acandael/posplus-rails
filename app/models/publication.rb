class Publication < ActiveRecord::Base
  include Hideable

  validates :title, :reference, presence: true
  before_save :scrub_reference

  has_many :project_publications
  has_many :research_projects, through: :project_publications

  has_many :documents

  belongs_to :category


  private

  def scrub_reference
    Loofah.fragment(reference).scrub!(:prune)
  end

  def self.filter(filter)
    if filter
      where(category_id: filter)
    end
  end

end
