class Insurance < ApplicationRecord
  belongs_to :patient

  validates :relationship, inclusion: { in: %w[person family] }

  # after_create_commit { PatientIndexerJob.perform_later("update", patient_id) }
  # after_destroy_commit { PatientIndexerJob.perform_later("update", patient_id) }
end
