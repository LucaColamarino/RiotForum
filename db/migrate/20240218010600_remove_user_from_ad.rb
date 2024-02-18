class RemoveUserFromAd < ActiveRecord::Migration[7.1]
  def change
    remove_column :ads, :user_id
  end
end
