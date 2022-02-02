class Patient < ApplicationRecord
  include PatientSearchable
  
  has_many :patient_addresses, dependent: :destroy # has_many :through
  has_many :addresses, through: :patient_addresses # Address model に patient_id は実装されていないけど patient.addresses で参照できるようになる
  has_many :insurances, dependent: :destroy

  has_one :memo, class_name: "PatientMemo", dependent: :destroy, inverse_of: :patient

  validates :gender, inclusion: { in: %w[male female other unknown] }
end
