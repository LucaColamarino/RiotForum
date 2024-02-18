class AddTeamToAds < ActiveRecord::Migration[7.1]
  def change
    add_reference :ads, :team, null: false, foreign_key: true

    remove_column :ads, :game
    remove_column :ads, :mode
    remove_column :ads, :lanes
  end
end
