require 'elasticsearch/model'

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :title, analyzer: 'english'
        indexes :body, analyzer: 'english'
      end
    end

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

  # Delete the previous publication index in Elasticsearch
  self.__elasticsearch__.client.indices.delete index: 'publication' rescue nil

  # Create the new index with the new mapping
  self.__elasticsearch__.client.indices.create \
    index: 'publication',
    body: { settings: self.settings.to_hash, mappings: self.mappings.to_hash }

  # Index all article records from the DB to Elasticsearch
  self.import(force: true)
  end


end

