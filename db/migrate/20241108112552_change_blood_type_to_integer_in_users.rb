class ChangeBloodTypeToIntegerInUsers < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :blood_type, 'integer USING blood_type::integer'
  end
end
