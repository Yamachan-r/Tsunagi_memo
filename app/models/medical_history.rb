class MedicalHistory < ApplicationRecord
  belongs_to :user

  encrypts :disease
  encrypts :treatment_status
  encrypts :disease_notes

  validates :disease, presence: true, length: { maximum: 100 }
  validates :treatment_status, length: { maximum: 200 }
  validates :disease_notes, length: { maximum: 30000 }
end
