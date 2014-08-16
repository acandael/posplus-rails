require 'elasticsearch/model'

class Publication < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Hideable

  validates :title, :body, presence: true
  before_save :scrub_body

  has_many :project_publications
  has_many :research_projects, through: :project_publications

  has_many :documents

  belongs_to :category

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'body']
          }
        },
        highlight: {
          pre_tags: ['<em class="highlight">'],
          post_tags: ['</em>'],
          fields: {
            title: {},
            body: {}
          }
        }
      }
    )
  end

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
      indexes :body, analyzer: 'english'
    end
  end

  private

  def scrub_body
    Loofah.fragment(body).scrub!(:prune)
  end

  def self.filter(filter)
    if filter
      where(category_id: filter)
    end
  end
  



end

# Delete the previous publication index in Elasticsearch
Publication.__elasticsearch__.client.indices.delete index: Publication.index_name rescue nil

# Create the new index with the new mapping
Publication.__elasticsearch__.client.indices.create \
  index: Publication.index_name,
  body: { settings: Publication.settings.to_hash, mappings: Publication.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Publication.import(force: true)
