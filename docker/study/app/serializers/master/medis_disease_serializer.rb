# frozen_string_literal: true

class Master::MedisDiseaseSerializer < ApplicationSerializer
  attributes :id
  attributes :change_type
  attributes :disease_managed_number
  attributes :disease_name
  attributes :disease_phonetic_name
  attributes :adoption_type
  attributes :disease_exchange_code
  attributes :icd10_2013
  attributes :icd10_2013_multiple_class_code
  attributes :reserve1
  attributes :reserve2
  attributes :receipt_code
  attributes :disease_short_name
  attributes :usage_division
  attributes :change_history_number
  attributes :update_date
  attributes :migrated_disease_managed_number
  attributes :prohibition_use_alone_type
  attributes :uncoverd_insurance_type
  attributes :reserve3
  attributes :reserve4
  has_many :index_terms
  
  def index_terms
    Master::MedisIndex.where(disease_modifier_type: "1", term_code: object.disease_exchange_code).map(&:index_term)
  end
end
