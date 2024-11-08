class AddForeignKeyToMedicalHistories < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :medical_histories, :users, column: :user_id
  end
end
