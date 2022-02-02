module PatientSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    
    INDEX_FIELDS = %w(id name kana_name gender).freeze

    index_name "es_patient_#{Rails.env}"

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

    # 非同期でインデックスする
    attr_accessor :skip_callback # テスト用にcallbackをスキップできるようにする
    after_create_commit -> { PatientIndexerJob.perform_later("create", id) }, unless: :skip_callback
    after_update_commit -> { PatientIndexerJob.perform_later("update", id) }, unless: :skip_callback
    after_destroy_commit -> { PatientIndexerJob.perform_later("delete", id) }, unless: :skip_callback    
  end

  def as_indexed_json(option = {})
    self.as_json.select { |k, _| INDEX_FIELDS.include?(k) }
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
            fields: %w(name kana_name gender),
            type: 'cross_fields',
            query: query,
            operator: 'and'
          }
        }
      })
    end    
  end
end