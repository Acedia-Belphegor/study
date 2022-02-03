# frozen_string_literal: true

class Master::MedisDiseaseIndexerJob < ApplicationJob
  discard_on ActiveRecord::RecordNotFound

  # @param operation [String]
  # @param medis_disease_id [String]
  def perform(operation, medis_disease_id)
    Master::MedisDiseaseIndexer.call(operation: operation, medis_disease_id: medis_disease_id)
  end
end
