class Address < ApplicationRecord
  has_many :patient_addresses # has_many :through
  has_many :patients, through: :patient_addresses

  validates :use, inclusion: { in: %w[home work temp old] }
  validates :postal_code, length: { is: 7 }

  def to_location
    "#{prefecture}#{city}#{line}"
  end
end
