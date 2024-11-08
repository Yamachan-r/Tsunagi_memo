class CreateUserFamilyGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :user_family_groups do |t|
      t.belongs_to :user
      t.belongs_to :family_group

      t.timestamps
    end
  end
end
