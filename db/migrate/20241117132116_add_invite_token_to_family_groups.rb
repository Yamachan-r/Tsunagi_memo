class AddInviteTokenToFamilyGroups < ActiveRecord::Migration[7.2]
  def change
    add_column :family_groups, :invite_token, :string
    add_index :family_groups, :invite_token, unique: true
  end
end
