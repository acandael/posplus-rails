require "bonsai/elasticsearch/rails/version"

puts "Starting up a new ElasticSearch client with #{ENV['BONSAI_URL']}"
Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['BONSAI_URL']
