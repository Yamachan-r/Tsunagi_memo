class User < ApplicationRecord
  has_many :family_groups, through: :user_family_groups
  has_many :medical_histories, dependent: :destroy

  validates :name, presence: true, length: { maximum: 40 }
  
  enum blood_type: { A: 0, B: 1, O: 2, AB: 3 }
end
