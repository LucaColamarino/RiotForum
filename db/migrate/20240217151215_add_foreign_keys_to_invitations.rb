class AddForeignKeysToInvitations < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :invitations, :users, column: :user_id
    add_foreign_key :invitations, :users, column: :friend_id
    add_index :invitations, [:user_id, :friend_id], unique: true
  end
end
