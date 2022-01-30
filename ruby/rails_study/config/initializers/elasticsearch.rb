config = {
  host:  ENV['ELASTICSEARCH_HOST'] || "localhost:9200",
}

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
