class User < ApplicationRecord
  has_many :medical_histories, dependent: :destroy

  validates :name, presence: true, length: { maximum: 40 }
end
