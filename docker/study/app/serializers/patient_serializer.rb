# frozen_string_literal: true

class PatientSerializer < ApplicationSerializer
  attributes :id
  attributes :name
  attributes :kana_name
  attributes :gender
  attributes :birth_date
  has_many :nested_addresses, serializer: NestedAddressSerializer
  has_one :memo, serializer: PatientMemoSerializer

  def nested_addresses
    object.addresses # object = Patient model
  end

  def memo
    object.memo
  end
end
