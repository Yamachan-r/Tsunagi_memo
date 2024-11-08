class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null:false
      t.string :uid
      t.date :birth_date
      t.string :gender
      t.string :blood_type

      t.timestamps
    end
  end
end
