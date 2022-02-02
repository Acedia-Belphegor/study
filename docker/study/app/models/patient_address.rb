# has_many :through用のモデル
class PatientAddress < ApplicationRecord
  belongs_to :patient
  belongs_to :address

  # after_create_commit { PatientIndexerJob.perform_later("update", patient_id) }
  # after_destroy_commit { PatientIndexerJob.perform_later("update", patient_id) }
end
