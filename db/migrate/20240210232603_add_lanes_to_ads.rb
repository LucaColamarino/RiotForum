class AddLanesToAds < ActiveRecord::Migration[7.1]
  def change
    add_column :ads, :lanes, :string
  end
end
