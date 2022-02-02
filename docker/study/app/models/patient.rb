class Patient < ApplicationRecord
  include PatientSearchable
  
  validates :gender, inclusion: { in: %w[male female other unknown] }
end
