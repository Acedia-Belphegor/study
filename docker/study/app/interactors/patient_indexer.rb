# frozen_string_literal: true

class PatientIndexer < BaseInteractor
  # @!method self.call(args)
  #   @param args [Hash]
  #     * patient_id (String)
  #     * operation (String)
  #   @return [Interactor::Context]

  def call
    case context.operation
    when "create"
      create fetch_patient(context.patient_id)
    when "update"
      update fetch_patient(context.patient_id)
    when "delete"
      delete context.patient_id
    end
  end

  private

  def fetch_patient(patient_id)
    Patient.find patient_id
  end

  def create(patient)
    patient.__elasticsearch__.index_document
  end

  def update(patient)
    patient.__elasticsearch__.update_document
  end

  def delete(patient_id)
    Patient.__elasticsearch__.client.delete_by_query(
      index: Patient.index_name,
      type: Patient.document_type,
      body: { query: { ids: { values: [patient_id] } } }
    )
  end
end
