# frozen_string_literal: true

class NestedInsuranceSerializer < ApplicationSerializer
  attribute :id
  attribute :insurance_number
  attribute :insured_symbol
  attribute :insured_number
  attribute :insured_branch_number
  attribute :insured_name
  attribute :relationship
  attribute :start_at
  attribute :end_at
  attribute :payment_rate_for_outpatient
  attribute :payment_rate_for_inpatient
end
