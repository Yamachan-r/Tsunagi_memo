class CreateMedicalHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :medical_histories do |t|
      t.integer :user_id, null: false
      t.string :disease, null: false
      t.string :treatment_status
      t.integer :age_at_diagnosis
      t.text :disease_notes

      t.timestamps
    end
  end
end
