class CreateFamilyGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :family_groups do |t|
      t.string :name, null:false

      t.timestamps
    end
  end
end
