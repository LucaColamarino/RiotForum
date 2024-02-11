class AddUsersToAds < ActiveRecord::Migration[7.1]
  def change
    add_reference :ads, :user, foreign_key: true
  end
end
