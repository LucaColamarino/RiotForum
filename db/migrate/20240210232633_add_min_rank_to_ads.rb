class AddMinRankToAds < ActiveRecord::Migration[7.1]
  def change
    add_column :ads, :minRank, :string
  end
end
