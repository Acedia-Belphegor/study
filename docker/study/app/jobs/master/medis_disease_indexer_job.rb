# frozen_string_literal: true

class Master::MedisDiseaseIndexerJob < ApplicationJob
  discard_on ActiveRecord::RecordNotFound

  # @param operation [String]
  # @param medis_disease_id [String]
  def perform(operation, medis_disease_id)
    Master::MedisDiseaseIndexer.call(operation: operation, medis_disease_id: medis_disease_id)
  end
end
__END__

# Master::MedisDisease.all.each{ |disease| Master::MedisDiseaseIndexerJob.perform_later("update", disease.id) }
# Master::MedisDisease.all.each{ |disease| Master::MedisDiseaseIndexer.call(operation: "update", medis_disease_id: disease.id) }

# Master::MedisDisease.where('disease_name like ?','%腎炎%').each{ |disease| Master::MedisDiseaseIndexerJob.perform_now("update", disease.id) }
# Master::MedisDisease.where('disease_name like ?','%肝炎%').each{ |disease| Master::MedisDiseaseIndexerJob.perform_now("update", disease.id) }

# Master::MedisDisease.where(disease_exchange_code: "TADT").each{ |disease| Master::MedisDiseaseIndexerJob.perform_now("update", disease.id) }
