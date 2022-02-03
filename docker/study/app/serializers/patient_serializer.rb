# frozen_string_literal: true

class PatientSerializer < ApplicationSerializer
  attributes :id
  attributes :name
  attributes :kana_name
  attributes :gender
  attributes :birth_date
  has_many :nested_addresses, serializer: NestedAddressSerializer
  has_many :nested_insurances, serializer: NestedInsuranceSerializer
  has_one :memo, serializer: PatientMemoSerializer

  def nested_addresses
    object.addresses # object = Patient model
  end

  def nested_insurances
    object.insurances
  end

  def memo
    object.memo
  end
end
__END__

patient = Patient.first
PatientSerializer.new(patient).as_json
