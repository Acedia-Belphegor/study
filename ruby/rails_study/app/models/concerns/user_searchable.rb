module UserSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    
    INDEX_FIELDS = %w(id name kana_name).freeze

    index_name "es_user_#{Rails.env}"

    settings do
      mappings dynamic: 'false' do # 動的にマッピングを生成しない
        indexes :id, type: "integer"
        indexes :name, type: "text", analyzer: 'kuromoji'
        indexes :kana_name, type: "text", analyzer: 'kuromoji'
        # indexes :microposts, type: "keyword", analyzer: 'kuromoji'
      end
    end

    # def as_indexed_json(*)
    #   attributes
    #     .symbolize_keys
    #     .slice(:id, :name)
    #     # .merge(publisher: publisher_name, author: author_name, category: category_name)
    # end    

    def as_indexed_json(option = {})
      self.as_json.select { |k, _| INDEX_FIELDS.include?(k) }
    end
  end

  class_methods do
    def create_index!
      client = __elasticsearch__.client
      # すでにindexを作成済みの場合は削除する
      client.indices.delete index: self.index_name rescue nil
      # indexを作成する
      client.indices.create(index: self.index_name,
                            body: {
                              settings: self.settings.to_hash,
                              mappings: self.mappings.to_hash
                            })
    end

    def es_search(query)
      __elasticsearch__.search({
        query: {
          multi_match: {
            fields: %w(name kana_name),
            type: 'cross_fields',
            query: query,
            operator: 'and'
          }
        }
      })
    end    
  end
end