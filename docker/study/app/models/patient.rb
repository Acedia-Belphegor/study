class Patient < ApplicationRecord
  validates :gender, inclusion: { in: %w[male female other unknown] }
end
