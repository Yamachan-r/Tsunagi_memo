class FamilyGroup < ApplicationRecord
  has_many :user_family_groups
  has_many :users, through: :user_family_groups

  validates :name, presence: true, length: { maximum: 40 }
end
