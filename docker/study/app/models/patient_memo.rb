class PatientMemo < ApplicationRecord
  belongs_to :patient

  # after_create_commit { PatientIndexerJob.perform_later("update", patient_id) }
  # after_destroy_commit { PatientIndexerJob.perform_later("update", patient_id) }
end
