class RenameUidToHashedUid < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :uid, :hashed_uid
  end
end
