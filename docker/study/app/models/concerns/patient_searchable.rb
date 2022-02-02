module PatientSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    
    # INDEX_FIELDS = %w(id name kana_name gender memo).freeze

    index_name "es_patient_#{Rails.env}"

    # settings do
    # end

    mappings do
      indexes :id, type: "integer"
      indexes :name, type: "text", analyzer: 'kuromoji_ja_analyzer'
      indexes :kana_name, type: "text", analyzer: 'kuromoji_ja_analyzer'

      indexes :nested_addresses, type: "nested" do
        indexes :id, type: "keyword"
        indexes :use, type: "keyword"
        indexes :postal_code, type: "keyword"
        indexes :prefecture, type: "text", analyzer: "kuromoji_ja_analyzer"
        indexes :city, type: "text", analyzer: "kuromoji_ja_analyzer"
        indexes :line, type: "text", analyzer: "kuromoji_ja_analyzer"
        indexes :address, type: "text", analyzer: "kuromoji_ja_analyzer"
      end

      indexes :memo do
        indexes :content, type: "text", analyzer: "kuromoji_ja_analyzer"
      end
    end

    # 非同期でインデックスする
    attr_accessor :skip_callback # テスト用にcallbackをスキップできるようにする
    after_create_commit -> { PatientIndexerJob.perform_later("create", id) }, unless: :skip_callback
    after_update_commit -> { PatientIndexerJob.perform_later("update", id) }, unless: :skip_callback
    after_destroy_commit -> { PatientIndexerJob.perform_later("delete", id) }, unless: :skip_callback    
  end

  def as_indexed_json(options = {})
    # self.as_json.select { |k, _| INDEX_FIELDS.include?(k) }
    PatientSerializer.new(self, options).as_json
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