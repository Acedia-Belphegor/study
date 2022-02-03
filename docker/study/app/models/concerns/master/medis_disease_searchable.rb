module Master::MedisDiseaseSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    
    index_name "medis_disease_#{Rails.env}"

    # settings do
    # end

    mappings do
      indexes :id, type: "keyword"
      indexes :change_type, type: "keyword"
      indexes :disease_managed_number, type: "keyword"
      indexes :disease_name, type: "text", analyzer: 'kuromoji_ja_analyzer'
      indexes :disease_phonetic_name, type: "text", analyzer: 'kuromoji_ja_analyzer'
      indexes :adoption_type, type: "keyword"
      indexes :disease_exchange_code, type: "keyword"
      indexes :icd10_2013, type: "keyword"
      indexes :icd10_2013_multiple_class_code, type: "keyword"
      indexes :reserve1, type: "keyword"
      indexes :reserve2, type: "keyword"
      indexes :receipt_code, type: "keyword"
      indexes :disease_short_name, type: "text", analyzer: 'kuromoji_ja_analyzer'
      indexes :usage_division, type: "keyword"
      indexes :change_history_number, type: "keyword"
      indexes :update_date, type: "keyword"
      indexes :migrated_disease_managed_number, type: "keyword"
      indexes :prohibition_use_alone_type, type: "keyword"
      indexes :uncoverd_insurance_type, type: "keyword"
      indexes :reserve3, type: "keyword"
      indexes :reserve4, type: "keyword"
    
      indexes :index_terms, type: "nested" do
        indexes :index_term, type: "text", analyzer: 'kuromoji_ja_analyzer'
      end
    end

    # 非同期でインデックスする
    attr_accessor :skip_callback # テスト用にcallbackをスキップできるようにする
    after_create_commit -> { Master::MedisDiseaseIndexerJob.perform_later("create", id) }, unless: :skip_callback
    after_update_commit -> { Master::MedisDiseaseIndexerJob.perform_later("update", id) }, unless: :skip_callback
    after_destroy_commit -> { Master::MedisDiseaseIndexerJob.perform_later("delete", id) }, unless: :skip_callback    
  end

  def as_indexed_json(options = {})
    Master::MedisDiseaseSerializer.new(self, options).as_json
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
  end
end