# frozen_string_literal: true

class PatientIndexerJob < ApplicationJob
  discard_on ActiveRecord::RecordNotFound

  # @param operation [String]
  # @param patient_id [String]
  def perform(operation, patient_id)
    PatientIndexer.call(operation: operation, patient_id: patient_id)
  end
end
