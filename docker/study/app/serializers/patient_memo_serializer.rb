# frozen_string_literal: true

class PatientMemoSerializer < ApplicationSerializer
  attribute :id
  attribute :patient_id
  attribute :content
end
