class User < ApplicationRecord
  has_many :user_family_groups
  has_many :family_groups, through: :user_family_groups
  has_many :medical_histories, dependent: :destroy

  encrypts :name
  encrypts :birth_date
  encrypts :gender

  validates :name, presence: true, length: { maximum: 40 }
  validates :hashed_uid, uniqueness: true

  enum blood_type: { A: 0, B: 1, O: 2, AB: 3 }

  # UIDをハッシュ化するメソッド
  def self.hash_uid(uid)
    salt = Rails.application.credentials.fixed_salt
    Digest::SHA256.hexdigest(uid + salt)
  end
end
