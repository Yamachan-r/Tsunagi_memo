class UserFamilyGroup < ApplicationRecord
  belongs_to :user
  belongs_to :family_group
end
