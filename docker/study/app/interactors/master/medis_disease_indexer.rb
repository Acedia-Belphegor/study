# frozen_string_literal: true

class Master::MedisDiseaseIndexer < BaseInteractor
  # @!method self.call(args)
  #   @param args [Hash]
  #     * medis_disease_id (String)
  #     * operation (String)
  #   @return [Interactor::Context]

  def call
    case context.operation
    when "create"
      create fetch(context.medis_disease_id)
    when "update"
      update fetch(context.medis_disease_id)
    when "delete"
      delete context.medis_disease_id
    end
  end

  private

  def fetch(id)
    Master::MedisDisease.find id
  end

  def create(instance)
    instance.__elasticsearch__.index_document
  end

  def update(instance)
    instance.__elasticsearch__.update_document
  end

  def delete(id)
    Master::MedisDisease.__elasticsearch__.client.delete_by_query(
      index: Master::MedisDisease.index_name,
      type: Master::MedisDisease.document_type,
      body: { query: { ids: { values: [id] } } }
    )
  end
end
