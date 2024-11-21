class ChangeBirthDateTypeInUsersToString < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :birth_date, :string
  end
end
