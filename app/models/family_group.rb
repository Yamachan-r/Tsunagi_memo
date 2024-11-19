class FamilyGroup < ApplicationRecord
  has_many :user_family_groups
  has_many :users, through: :user_family_groups

  validates :name, presence: true, length: { maximum: 40 }

  # 招待トークン生成
  def generate_invite_token
    self.invite_token = SecureRandom.urlsafe_base64
    save
  end
end
