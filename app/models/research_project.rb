class ResearchProject < ActiveRecord::Base
  include Closeable
  include Searchable

  validates :title, :body, presence: true

  has_many :theme_projects, dependent: :destroy
  has_many :research_themes, through: :theme_projects

  has_many :project_researchers
  has_many :researchers, through: :project_researchers

  has_many :project_publications
  has_many :publications, through: :project_publications

  mount_uploader :image, ResearchProjectImageUploader


end

# Delete the previous publication index in Elasticsearch
Publication.__elasticsearch__.client.indices.delete index: Publication.index_name rescue nil

# Create the new index with the new mapping
Publication.__elasticsearch__.client.indices.create \
  index: Publication.index_name,
  body: { settings: Publication.settings.to_hash, mappings: Publication.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Publication.import(force: true)

