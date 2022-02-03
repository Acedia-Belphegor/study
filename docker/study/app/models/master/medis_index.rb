class Master::MedisIndex < ApplicationRecord
  # has_many :diseases, class_name: "Master::MedisDisease", foreign_key: "term_code"

  # has_many :master_medis_indices
  # has_many :diseases, through: :master_medis_indices

  validates :disease_modifier_type, inclusion: { in: %w[1 2] } # 1:病名 2:修飾語
end