# frozen_string_literal: true

class NestedAddressSerializer < ApplicationSerializer
  attribute :id
  attribute :use
  attribute :postal_code
  attribute :prefecture
  attribute :city
  attribute :line
  attribute :address

  def address
    object.to_location
  end
end
