class Publication < ActiveRecord::Base
  include Hideable
  include Searchable

  validates :title, :body, :year, presence: true
  validates :year, numericality: true
  validates :series, numericality: true, allow_blank: true
  before_save :scrub_body

  has_many :project_publications
  has_many :research_projects, through: :project_publications

  has_many :publication_researchers
  has_many :researchers, through: :publication_researchers

  has_many :documents

  belongs_to :category


  private

  def scrub_body
    Loofah.fragment(body).scrub!(:prune)
  end

  def self.filter(filter)
    if filter
      where(category_id: filter)
    end
  end

  def self.latest
    order('year DESC').limit(3)
  end

end

