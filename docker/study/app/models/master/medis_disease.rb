class Master::MedisDisease < ApplicationRecord
  include Master::MedisDiseaseSearchable
  
  # has_many :indices, foreign_key: "disease_exchange_code", primary_key: "term_code", class_name: "MedisIndex", required: false
  # has_many :indices, class_name: "Master::MedisIndex", foreign_key: "disease_exchange_code", required: false

  # has_many :master_medis_indices
  # has_many :indices, through: :master_medis_indices

  # has_many :disease_type_relations
  # has_many :disease_types, through: :disease_type_relations

  # def self.periodontal_diseases
  #   joins(:disease_types).merge(Master::DiseaseType.periodontal_disease)
  # end
end