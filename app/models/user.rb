class User < ApplicationRecord
  has_many :user_family_groups
  has_many :family_groups, through: :user_family_groups
  has_many :medical_histories, dependent: :destroy

  encrypts :name
  encrypts :birth_date

  validates :name, presence: true, length: { maximum: 40 }
  validates :hashed_uid, uniqueness: true

  enum gender: { 男性: 0, 女性: 1, その他: 2 }
  enum blood_type: { A型: 0, B型: 1, O型: 2, AB型: 3, 不明: 4 }

  # UIDをハッシュ化するメソッド
  def self.hash_uid(uid)
    salt = Rails.application.credentials.fixed_salt
    Digest::SHA256.hexdigest(uid + salt)
  end
end
