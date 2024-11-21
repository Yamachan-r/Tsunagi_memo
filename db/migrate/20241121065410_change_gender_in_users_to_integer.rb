class ChangeGenderInUsersToInteger < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :gender, 'integer USING blood_type::integer'
  end
end
