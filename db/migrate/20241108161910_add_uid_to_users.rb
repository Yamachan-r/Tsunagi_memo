class AddUidToUsers < ActiveRecord::Migration[7.2]
  def change
    add_index :users, :uid, unique: true
  end
end
